import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ClienteSQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE clientes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nomeCliente TEXT,
        telefoneCliente TEXT,
        createdAtCliente TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""CREATE TABLE login(
      idLogin INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      usuario TEXT,
      senha TEXT
    )
""");
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'loja.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(String nome, String? telefone) async {
    final db = await ClienteSQLHelper.db();

    final data = {'nomeCliente': nome, 'telefoneCliente': telefone};
    final id = await db.insert('clientes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await ClienteSQLHelper.db();
    return db.query('clientes', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await ClienteSQLHelper.db();
    return db.query('clientes', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String nome, String? telefone) async {
    final db = await ClienteSQLHelper.db();

    final data = {
      'nomeCliente': nome,
      'telefoneCliente': telefone,
      'createdAtCliente': DateTime.now().toString()
    };

    final result =
        await db.update('clientes', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await ClienteSQLHelper.db();
    try {
      await db.delete("clientes", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
