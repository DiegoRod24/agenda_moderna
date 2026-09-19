# ⚖️ ARV — Agenda Jurídica Inteligente

Aplicación móvil para Android y iPhone pensada como asistente jurídico personal.

**Perfil piloto:** Diego Alfredo Rodríguez Villalobos  
**Identidad visual:** azul marino + dorado, basada en el sello ARV.

## Qué ya contiene esta primera base

- Pantalla móvil “Hoy”.
- Resumen del día.
- Tarjetas de urgencia, pendientes y correos.
- Agenda demo.
- Botón rápido para dictar, cita, tarea, caso, evidencia y nota.
- Captura por voz en español.
- Botón para abrir Google Meet.
- Notificación local de prueba.
- Tema visual ARV.
- Esquema inicial Supabase con RLS.
- Arquitectura preparada para Gmail, Calendar, Meet y evidencias.

## Ejecutar

Necesitas Flutter instalado.

```bash
git clone https://github.com/DiegoRod24/agenda_moderna.git
cd agenda_moderna

# Como el repositorio empezó vacío, genera una vez los contenedores nativos:
flutter create . --platforms=android,ios

flutter pub get

# Crear archivo .env desde el ejemplo
cp .env.example .env

flutter run
```

En Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

## Backend propuesto

Supabase.

1. Crear proyecto.
2. Abrir SQL Editor.
3. Ejecutar `supabase/schema.sql`.
4. Copiar URL y ANON KEY a `.env`.
5. Crear bucket privado `case-files`.

## Flujo de notificación objetivo

Ejemplo para una audiencia a las 10:00:

- Día anterior 21:30 → “Mañana tiene audiencia. Aún falta revisar el escrito.”
- Mismo día 07:30 → “Buenos días, Doctor. Hoy tiene audiencia a las 10:00.”
- 09:30 → “Audiencia en 30 minutos.”
- 09:50 → “¿Está listo? Revise el caso.”
- 09:55 → botón “Abrir Meet”.
- Al terminar → “¿Desea registrar una acción posterior?”

## Próximo bloque

- Navegación real entre Hoy / Agenda / Casos / ARV.
- CRUD de eventos.
- CRUD de clientes y casos.
- Evidencias con foto/video/documentos.
- Recordatorios programados.
- Resumen nocturno y matutino.
- Login biométrico.
- Conexión Supabase.
- Google OAuth.
