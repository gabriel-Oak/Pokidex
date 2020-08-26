import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';

class PokemonService {
  final PokemonHelper pokemonHelper;
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2/pokemon',
      responseType: ResponseType.json,
      connectTimeout: 25000,
      receiveTimeout: 25000,
      sendTimeout: 25000,
    ),
  );

  PokemonService({@required this.pokemonHelper});

  Future<Map> getPokemons({offSet = 0}) async {
    try {
      final response = await dio.get('', queryParameters: {
        'offset': offSet,
        'limit': 20,
      });

      final List results = response.data['results'];

      final detailedList = (await Future.wait(
        results.map((p) async {
          final id = int.parse(p['url'].substring(34, p['url'].length - 1));
          return getDetails(id: id);
        }),
      ))
          .where((pokemon) => pokemon != null)
          .toList();
      return {
        'count': response.data['count'],
        'hasNext': response.data['next'] != null,
        'hasPrev': response.data['previous'] != null,
        'pokemons': detailedList,
      };
    } on DioError {
      print('Not connected');
    } catch (e) {
      print(e);
    }

    return await pokemonHelper.getPaginated(offSet: offSet);
  }

  Future<Pokemon> getDetails({@required int id}) async {
    try {
      Pokemon pokemon = await pokemonHelper.getByApiId(apiId: id);

      if (pokemon == null) {
        final response = await dio.get('/$id');
        pokemon = Pokemon.fromApi(response.data);
        pokemonHelper.saveUpdate(pokemon);
      }

      return pokemon;
    } catch (e) {
      print(e);
      throw 'Couldn\'t fetch pokémon #${id.toString().padLeft(4, '0')}';
    }
  }
}
