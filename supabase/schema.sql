-- ARV / Agenda Moderna - esquema inicial
create extension if not exists "pgcrypto";

create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  display_name text,
  professional_title text default 'Abogado',
  logo_url text,
  created_at timestamptz not null default now()
);

create table if not exists clients (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  full_name text not null,
  phone text,
  email text,
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists legal_cases (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  client_id uuid references clients(id) on delete set null,
  title text not null,
  case_number text,
  court text,
  matter text,
  status text not null default 'activo',
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists agenda_items (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  case_id uuid references legal_cases(id) on delete set null,
  client_id uuid references clients(id) on delete set null,
  title text not null,
  description text,
  item_type text not null check (item_type in ('audiencia','reunion','tarea','llamada','vencimiento','evidencia')),
  start_at timestamptz not null,
  end_at timestamptz,
  meet_url text,
  location text,
  urgent boolean not null default false,
  completed boolean not null default false,
  source text not null default 'arv',
  external_id text,
  created_at timestamptz not null default now()
);

create table if not exists reminders (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  agenda_item_id uuid not null references agenda_items(id) on delete cascade,
  remind_at timestamptz not null,
  kind text not null default 'push',
  message text,
  sent_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists case_files (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  case_id uuid references legal_cases(id) on delete set null,
  file_type text not null,
  storage_path text not null,
  title text,
  note text,
  captured_at timestamptz not null default now()
);

alter table profiles enable row level security;
alter table clients enable row level security;
alter table legal_cases enable row level security;
alter table agenda_items enable row level security;
alter table reminders enable row level security;
alter table case_files enable row level security;

create policy "profiles own row" on profiles
  for all using (auth.uid() = id) with check (auth.uid() = id);

create policy "clients own rows" on clients
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "cases own rows" on legal_cases
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "agenda own rows" on agenda_items
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "reminders own rows" on reminders
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);

create policy "files own rows" on case_files
  for all using (auth.uid() = owner_id) with check (auth.uid() = owner_id);
