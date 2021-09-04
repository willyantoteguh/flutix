import 'package:bwa_flutix/models/models.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'dart:async';

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      var databasesPath = await getDatabasesPath();
      String _path = p.join(databasesPath, 'crud.db');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (n) {
      print(n);
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE newticket (id INTEGER PRIMARY KEY AUTOINCREMENT, movieDetail STRING, theater STRING, time STRING, bookingCode, seats STRING, totalSeats INT , name STRING, totalPrice REAL)');

    await db.execute(
        'CREATE TABLE theater (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING)');

    await db.execute(
        "INSERT INTO theater (name) VALUES ('CGV Royal Plaza'), ('CGV Galaxy Mall'), ('XXI Ciputra World'), ('XXI Pakuwon Trade Center');");
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  //! Insert
  static Future<int> insert(String table, DataModel model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, DataModel model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, DataModel model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

  static Future<Batch> batch() async => _db.batch();
}
