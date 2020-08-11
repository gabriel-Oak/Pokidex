import 'dart:convert';

import 'package:pokidex/helpers/init_database.dart';
import 'package:pokidex/helpers/pokemon_type.dart';
import 'package:sqflite/sqflite.dart';

final pokemonsTable = 'pokemons';
final idAppColumn = 'idApp';
final apiIdColumn = 'apiId';
final nameColumn = 'name';
final heigthColumn = 'heigth';
final weightColumn = 'weight';
final imgColumn = 'img';
final typesColumn = 'types';
final abilitiesColumn = 'abilities';

class PokemonHelper {
  //Creates a sigleton
  static final PokemonHelper _instance = PokemonHelper.internal();
  PokemonHelper.internal();
  factory PokemonHelper() => _instance;

  Database _db;

  get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future close() async {
    final Database database = await db;
    await database.close();
  }
}

class Pokemon {
  int idApp;
  int apiId;
  String name;
  int heigth;
  int weight;
  String img;
  List types;
  List abilities;

  Pokemon.fromStorage(Map map) {
    idApp = map[idAppColumn];
    apiId = map[apiIdColumn];
    name = map[idAppColumn];
    heigth = map[heigthColumn];
    weight = map[weightColumn];
    img = map[imgColumn];
    types = json
        .decode(map[typesColumn])
        .map((type) => PokemonType.fromMap(type))
        .toList();
    abilities = json.decode(map[abilitiesColumn]);
  }

  Pokemon.fromMap(Map map) {
    apiId = map['id'];
    name = map['name'][0];
    heigth = map['heigth'];
    weight = map['weight'];
    img = map['sprites']['front_default'];
    types = map['types']
        .map(
          (type) => PokemonType.fromApi(type),
        )
        .toList();
    abilities = map['abilities']
        .map(
          (ability) => ability['ability']['name'],
        )
        .toList();
  }
}
