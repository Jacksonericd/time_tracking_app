import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:time_tracking_app/core/services/local_storage/local_storage_service.dart';

class AppLocalStorageService implements LocalStorageService {
  late final Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // await db.execute('''
    //     CREATE TABLE task_list (
    //       id INTEGER PRIMARY KEY AUTOINCREMENT,
    //       task_details TEXT NOT NULL,
    //     )
    //   ''');

    await db.execute('''
        CREATE TABLE task_timer (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          task_id TEXT NOT NULL,
          start_time TEXT NOT NULL,
        )
      ''');
  }

  @override
  Future<dynamic> getTaskTimerById(String taskId) async {
    final db = await database;

    return await db
        .rawQuery('SELECT * FROM task_timer WHERE task_id = ?', [taskId]);
  }

  @override
  Future getAllTaskTimer() async {
    final db = await database;

    return await db.query('task_timer');
  }

  @override
  Future<void> insertTaskTime({
    required String taskId,
    required String startTime,
  }) async {
    final db = await database;

    await db.insert(
      'task_timer',
      {
        'task_id': taskId,
        'task_timer': startTime,
      },
    );
  }

  @override
  Future<void> updateTaskTime(
      {required String taskId, required String startTime}) async {
    final db = await database;

    await db.update(
      'task_timer',
      {
        'task_id': taskId,
        'task_timer': startTime,
      },
    );
  }

  @override
  Future<void> deleteTaskTime(String taskId) async {
    final db = await database;

    await db.delete(
      'task_timer',
      where: 'task_id = ?',
      whereArgs: [taskId],
    );
  }
}
