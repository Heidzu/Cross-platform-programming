import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _database;

  DatabaseManager._init();

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB('task_notes.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbDirectory = await getDatabasesPath();
    final dbPath = join(dbDirectory, dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createTable,
    );
  }

  Future _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        taskId INTEGER PRIMARY KEY AUTOINCREMENT,
        taskDescription TEXT,
        dateCreated TEXT
      )
    ''');
  }

  Future<int> insertTask(String description) async {
    final db = await instance.db;
    return await db.insert('tasks', {
      'taskDescription': description,
      'dateCreated': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final db = await instance.db;
    return await db.query('tasks', orderBy: 'taskId DESC');
  }

  Future closeDatabase() async {
    final db = await instance.db;
    await db.close();
  }
}
