// lib/database/database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'database/temperature_record.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'temperature_records.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create the table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE temperature_records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT,
        name TEXT,
        date TEXT,
        temperature REAL
      )
    ''');
  }

  // Insert a record
  Future<void> insertTemperatureRecord(TemperatureRecord record) async {
    final db = await database;
    await db.insert(
      'temperature_records',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all records
  Future<List<TemperatureRecord>> getTemperatureRecords() async {
    final db = await database;
    var result = await db.query('temperature_records');
    return result.map((record) => TemperatureRecord.fromMap(record)).toList();
  }
}
