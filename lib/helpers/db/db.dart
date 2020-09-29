import 'dart:async';

import 'package:pokidex/helpers/db/init_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Db {
  Future<Database> get() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'pokidex_1_0_1');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      onUpgrade: update,
      onDowngrade: update,
    );
    return db;
  }

  Future<void> create(Database db, int _newVersion) async {
    print('Criando DB');
    await initDb(db: db);
    print('Banco criado!');
  }

  Future<void> update(Database db, int _lastVersion, int newVersion) async {
    print('Atualizar');
    try {
      await _clear();
      await create(db, newVersion);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _clear() async {
    final db = await this.get();
    final tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    for (int i = 0; i < tables.length; i++) {
      final name = tables[i]['name'];
      if (name != 'android_metadata') {
        await db.delete('$name');
      }
    }
  }
}
