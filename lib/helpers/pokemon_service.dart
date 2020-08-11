import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/pokemon_helper.dart';

class PokemonService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/pokemon',
    responseType: ResponseType.json,
  ));

  Future<Map> getPokemons({offSet = 0}) async {
    final response = await dio.get('', queryParameters: {
      'offset': offSet,
      'limit': 20,
    });

    final List results = response.data['results'];

    final detailedList = await Future.wait(
      results.map((p) async => await getDetails(url: p['url'])),
    );

    print(detailedList.toList()[0].types);
    return response.data;
  }

  Future<Pokemon> getDetails({@required url}) async {
    final response = await Dio().get(url);
    return Pokemon.fromMap(response.data);
  }
}
