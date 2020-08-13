import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/pokemon_helper.dart';

class PokemonService {
  final PokemonHelper pokemonHelper;
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://pokeapi.co/api/v2/pokemon',
      responseType: ResponseType.json,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
    ),
  );

  PokemonService({@required this.pokemonHelper});

  Future<Map> getPokemons({offSet = 0}) async {
    try {
      Map pagination = await pokemonHelper.getPaginated(offSet: offSet);

      if (pagination == null || pagination['pokemons'].length == 0) {
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
        pagination = {
          'count': response.data['count'],
          'hasNext': response.data['next'] != null,
          'hasPrev': response.data['previous'] != null,
          'pokemons': detailedList,
        };
      }

      return pagination;
    } catch (e) {
      print(e);
      return null;
    }
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
      print('getDetails');
      print(e);
      return null;
    }
  }
}
