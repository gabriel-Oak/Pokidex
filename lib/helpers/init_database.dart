import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDb() async {
  final String databasePath = await getDatabasesPath();
  final String path = join(databasePath, 'pokidex.v015.db');

  return await openDatabase(path, version: 1, onCreate: (db, version) async {
    await db.execute(
      'CREATE TABLE pokemons' +
          '(' +
          'idApp INTEGER PRIMARY KEY,' +
          'apiId INTEGER UNIQUE,' +
          'name TEXT,' +
          'heigth INTEGER,' +
          'weight INTEGER,' +
          'img TEXT,' +
          'types TEXT,' +
          'abilities TEXT,' +
          'stats TEXT' +
          ');',
    );
  });
}
