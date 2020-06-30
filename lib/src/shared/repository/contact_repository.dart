import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:contactsapp/src/shared/repository/abstract_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

import '../../../application.dart';

class ContactRepository extends AbstractRepository with Disposable {
  static ContactRepository _this;

  factory ContactRepository() {
    if (_this == null) {
      _this = ContactRepository.getInstance();
    }
    return _this;
  }

  ContactRepository.getInstance() : super();


  @override
  Future<bool> delete(dynamic id) async {
    Database db = await this.database;
    int rows = await db.delete('contacts', where: 'id = ?', whereArgs: [id]);

    return (rows != 0);
  }

  @override
  Future<Map> getItem(int id) async {
    Database db = await this.database;
    List<Map> items =
        await db.query("contacts", where: 'id = ?', whereArgs: [id]);

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
    List<Map> items = await db.rawQuery("SELECT * FROM contacts ORDER BY firstName");
    return items;
  }

  Future<List<Map>> search(dynamic value) async {
    Database db = await this.database;
    List<Map> items = await db.rawQuery("""SELECT 
              * 
           FROM 
              contacts 
           WHERE 
              firstName LIKE '%$value%' or 
              lastName LIKE '%$value%' or 
              phoneNumber LIKE'%$value%' or 
              job LIKE'%$value%' or 
              email LIKE '%$value%' or
              comments LIKE '%$value%' or
              email LIKE '%$value%'
            ORDER BY firstName
        """);

    return items;
  }

  @override
  Future<bool> update(Map<String, dynamic> values, id) async {
    Database db = await this.database;
    int rows =
        await db.update('contacts', values, where: 'id = ?', whereArgs: [id]);
    return (rows != 0);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
