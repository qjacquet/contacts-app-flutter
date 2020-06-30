import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';
import '../../../application.dart';

abstract class AbstractRepository {
  static Database _database;
  String path;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _open();
    print(await _database.query('contacts'));
    return _database;
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);

    return await openDatabase(path,
        version: migrations.length,
        onCreate: (Database db, int version) async {
          migrate(db, 0, version);
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          print('passed');
          migrate(db, oldVersion, newVersion);
        });
  }

  static migrate(Database db, int oldVersion, int newVersion) async {
    for (var i = oldVersion; i <= newVersion - 1; i++) {
      await db.execute(migrations[i]);
    }
  }

  Future<List<Map>> list();

  Future<Map> getItem(int id);

  Future<int> insert(Map<String, dynamic> values);

  Future<bool> update(Map<String, dynamic> values, dynamic where);

  Future<bool> delete(int id);
}
