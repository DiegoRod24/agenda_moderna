import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  LocalDatabaseService._();

  static final instance = LocalDatabaseService._();

  Database? _db;
  Database get db => _db!;

  Future<void> init() async {
    final root = await getDatabasesPath();
    final dbPath = join(root, 'arv_agenda.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE agenda_items (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            item_type TEXT NOT NULL,
            start_at TEXT NOT NULL,
            end_at TEXT,
            case_name TEXT,
            client_name TEXT,
            meet_url TEXT,
            location TEXT,
            urgent INTEGER NOT NULL DEFAULT 0,
            completed INTEGER NOT NULL DEFAULT 0,
            synced INTEGER NOT NULL DEFAULT 0,
            updated_at TEXT NOT NULL
          )
        ''');

        await database.execute('''
          CREATE TABLE legal_cases (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            case_number TEXT,
            client_name TEXT,
            court TEXT,
            matter TEXT,
            status TEXT NOT NULL DEFAULT 'activo',
            notes TEXT,
            synced INTEGER NOT NULL DEFAULT 0,
            updated_at TEXT NOT NULL
          )
        ''');

        await database.execute('''
          CREATE TABLE evidence (
            id TEXT PRIMARY KEY,
            case_id TEXT,
            type TEXT NOT NULL,
            local_path TEXT NOT NULL,
            title TEXT,
            note TEXT,
            captured_at TEXT NOT NULL,
            synced INTEGER NOT NULL DEFAULT 0
          )
        ''');
      },
    );
  }

  Future<int> pendingSyncCount() async {
    final result = await db.rawQuery('''
      SELECT
        (SELECT COUNT(*) FROM agenda_items WHERE synced = 0) +
        (SELECT COUNT(*) FROM legal_cases WHERE synced = 0) +
        (SELECT COUNT(*) FROM evidence WHERE synced = 0) AS total
    ''');

    return (result.first['total'] as int?) ?? 0;
  }
}
