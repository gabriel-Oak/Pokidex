import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokidex/helpers/init_database.dart';
import 'package:pokidex/helpers/pokemons/poke_colors.dart';
import 'package:pokidex/helpers/pokemons/pokemon_stat.dart';
import 'package:pokidex/helpers/pokemons/pokemon_type.dart';
import 'package:sqflite/sqflite.dart';

final pokemonsTable = 'pokemons';
final apiIdColumn = 'apiId';
final nameColumn = 'name';
final heigthColumn = 'heigth';
final weightColumn = 'weight';
final imgColumn = 'img';
final typesColumn = 'types';
final abilitiesColumn = 'abilities';
final statsColumn = 'stats';

class PokemonHelper {
  //Creates a sigleton
  static final PokemonHelper _instance = PokemonHelper.internal();
  PokemonHelper.internal();
  factory PokemonHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future close() async {
    final database = await db;
    await database.close();
  }

  Future<int> saveUpdate(Pokemon pokemon) async {
    final database = await db;
    final hasPokemon = await getByApiId(apiId: pokemon.apiId) != null;

    return hasPokemon
        ? await database.update(
            pokemonsTable,
            pokemon.toMap(),
            where: '$apiIdColumn = ?',
            whereArgs: [pokemon.apiId],
          )
        : await database.insert(pokemonsTable, pokemon.toMap());
  }

  Future<Map<String, dynamic>> getPaginated({@required int offSet}) async {
    try {
      final database = await db;

      final Map count = (await database.rawQuery(
        'SELECT COUNT(*) as count FROM $pokemonsTable;',
      ))
          .first;

      List pokemons = await database.rawQuery(
        'SELECT * FROM $pokemonsTable ORDER BY $apiIdColumn ASC LIMIT 20 OFFSET $offSet;',
      );

      pokemons = pokemons.map((e) => Pokemon.fromStorage(e)).toList();
      return {
        ...count,
        'pokemons': pokemons,
        'hasPrev': offSet - 20 >= 0,
        'hasNext': pokemons.length == 20 && offSet + 20 <= count['count'],
      };
    } catch (e) {
      print(e);
      throw 'Got something wrong fetching data localy!';
    }
  }

  Future<Pokemon> getByApiId({@required apiId}) async {
    final database = await db;
    final List<Map> pokemons = await database.query(
      pokemonsTable,
      columns: [
        apiIdColumn,
        nameColumn,
        heigthColumn,
        weightColumn,
        imgColumn,
        typesColumn,
        abilitiesColumn,
        statsColumn,
      ],
      where: '$apiIdColumn = ?',
      whereArgs: [apiId],
    );

    return pokemons.length > 0 ? Pokemon.fromStorage(pokemons.first) : null;
  }
}

class Pokemon {
  int apiId;
  String name;
  int heigth;
  int weight;
  String img;
  List types;
  List abilities;
  int cardColor;
  List stats;

  Pokemon.fromStorage(Map map) {
    final List t = json
        .decode(map[typesColumn])
        .map((type) => PokemonType.fromMap(type))
        .toList();

    apiId = map[apiIdColumn];
    name = map[nameColumn];
    heigth = map[heigthColumn];
    weight = map[weightColumn];
    img = map[imgColumn];
    types = t;
    abilities = json.decode(map[abilitiesColumn]);
    stats = json
        .decode(map[statsColumn])
        .map((e) => PokemonStat.fromMap(e))
        .toList();
    cardColor = int.parse(
      pokeColor[t.where((e) => e.slot == 1).first.name]
          .replaceAll(RegExp(r'#'), '0xFF'),
    );
  }

  Pokemon.fromApi(Map map) {
    final List<String> splitedName = map['name'].split(' ');
    final t = map['types']
        .map(
          (type) => PokemonType.fromApi(type),
        )
        .toList();

    apiId = map['id'];
    heigth = map['heigth'];
    weight = map['weight'];
    img = map['sprites']['front_default'];
    name = splitedName
        .map((segment) => '${segment[0].toUpperCase()}${segment.substring(1)}')
        .join(' ');
    types = t;
    abilities = map['abilities']
        .map(
          (ability) => ability['ability']['name'],
        )
        .toList();
    cardColor = int.parse(
      pokeColor[t.where((e) => e.slot == 1).first.name]
          .replaceAll(RegExp(r'#'), '0xFF'),
    );
    stats = map['stats'].map((e) => PokemonStat.fromApi(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      apiIdColumn: apiId,
      nameColumn: name,
      heigthColumn: heigth,
      weightColumn: weight,
      imgColumn: img,
      typesColumn: json.encode(types.map((type) => type.toMap()).toList()),
      statsColumn: json.encode(stats.map((e) => e.toMap()).toList()),
      abilitiesColumn: json.encode(abilities),
    };
  }
}
