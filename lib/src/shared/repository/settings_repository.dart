import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contactsapp/src/shared/repository/abstract_repository.dart';
import 'package:sqflite/sqflite.dart';

class SettingsRepository extends AbstractRepository with Disposable {
  static SettingsRepository _this;

  factory SettingsRepository() {
    if (_this == null) {
      _this = SettingsRepository.getInstance();
    }
    return _this;
  }

  SettingsRepository.getInstance() : super();


  @override
  Future<bool> delete(dynamic id) async {
    Database db = await this.database;
    int rows = await db.delete('settings', where: 'id = ?', whereArgs: [id]);

    return (rows != 0);
  }

  @override
  Future<Map> getItem(int id) async {
    Database db = await this.database;
    List<Map> items =
    await db.query("settings", where: 'id = ?', whereArgs: [id]);

    if (items.isNotEmpty) {
      return items.first;
    }
    return Map();
  }

  @override
  Future<int> insert(Map<String, dynamic> values) async {
    Database db = await this.database;
    int newId = await db.insert('contacts', values);
    return newId;
  }

  @override
  Future<List<Map>> list() async {
    Database db = await this.database;
    List<Map> items = await db.rawQuery("SELECT * FROM settings");
    return items;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, id) async {
    Database db = await this.database;
    int rows =
    await db.update('settings', values, where: 'id = ?', whereArgs: [id]);
    return (rows != 0);
  }

  Future<bool> isGoodPassword(String password) async {
    Database db = await this.database;
    Map item = await getItem(1);
    return item['appPassword'] == password;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
