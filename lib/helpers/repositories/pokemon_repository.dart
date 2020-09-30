import 'package:flutter/material.dart';
import 'package:pokidex/helpers/db/db.dart';
import 'package:pokidex/helpers/db/init_db.dart';
import 'package:pokidex/helpers/db/scripts/pokemonsTable.dart';
import 'package:pokidex/helpers/models/pokemon_model.dart';
import 'package:sqflite/sqflite.dart';

class PokemonRepository {
  final Db db;

  PokemonRepository({@required this.db});

  Future close() async {
    final database = await db.get();
    await database.close();
  }

  Future<int> saveUpdate(PokemonModel pokemon) async {
    final database = await db.get();
    final hasPokemon = await getByApiId(apiId: pokemon.apiId) != null;

    return hasPokemon
        ? await database.update(
            'pokemons',
            pokemon.toMap(),
            where: 'apiId = ?',
            whereArgs: [pokemon.apiId],
          )
        : await database.insert('pokemons', pokemon.toMap());
  }

  Future<Map<String, dynamic>> getPaginated({@required int offSet}) async {
    final database = await db.get();
    try {
      final Map count = await database
          .rawQuery('SELECT COUNT(*) as count FROM pokemons;')
          .then((value) => value.first);

      List pokemons = await database.query(
        'pokemons',
        columns: pokemonsColumns,
        orderBy: 'apiId ASC',
        limit: 20,
        offset: offSet,
      );

      pokemons = pokemons.map((e) => PokemonModel.fromStorage(e)).toList();
      return {
        ...count,
        'pokemons': pokemons,
        'hasPrev': offSet - 20 >= 0,
        'hasNext': pokemons.length == 20 && offSet + 20 <= count['count'],
      };
    } on DatabaseException {
      await initDb(db: database);
      return await getPaginated(offSet: offSet);
    } catch (e) {
      print(e);
      throw 'Got something wrong fetching data localy!';
    }
  }

  Future<PokemonModel> getByApiId({@required apiId}) async {
    final database = await db.get();
    final List<Map> pokemons = await database.query(
      'pokemons',
      columns: pokemonsColumns,
      where: 'apiId = ?',
      whereArgs: [apiId],
    );

    return pokemons.length > 0
        ? PokemonModel.fromStorage(pokemons.first)
        : null;
  }
}
