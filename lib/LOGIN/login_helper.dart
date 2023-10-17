import 'dart:async';
import 'package:pesquisa_flutter/SQFLITE/cliente_helper.dart';
import 'package:sqflite/sqflite.dart' as sql;

class LoginCtr {
  // Create new item (login)
  static Future<int> createItem(String nome, String? senha) async {
    final db = await ClienteSQLHelper.db();

    final data = {'usuario': nome, 'senha': senha};
    final id = await db.insert('login', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await ClienteSQLHelper.db();
    return db.query('login', orderBy: "idLogin");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(
      String nome, String senha) async {
    final db = await ClienteSQLHelper.db();
    return db.query('login',
        where: "usuario = ? and senha=?", whereArgs: [nome, senha], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String nome, String? senha) async {
    final db = await ClienteSQLHelper.db();

    final data = {
      'usuario': nome,
      'senha': senha,
    };

    final result =
        await db.update('login', data, where: "idLogin = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await ClienteSQLHelper.db();
    try {
      await db.delete("login", where: "idLogin = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }
}
