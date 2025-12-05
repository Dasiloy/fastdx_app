import "dart:async";

import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqlite_api.dart";
import "package:path/path.dart" as path;

class Db {
  static Future<Database> createDb() async {
    final dbDir = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbDir, "fastdx_app.db"),
      version: 1,
      onCreate: (db, version) => db.execute('''
      CREATE TABLE carts (
      id TEXT PRIMARY KEY
    )
  '''),
    );

    return db;
  }
}
