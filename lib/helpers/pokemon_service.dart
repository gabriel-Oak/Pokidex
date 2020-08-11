import 'package:dio/dio.dart';

class PokemonService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/pokemon',
    responseType: ResponseType.json,
  ));

  Future<List> getPokemons({offSet = 0}) async {
    final response = await dio.get('', queryParameters: {
      'offset': offSet,
      'limit': 20,
    });
    print(response.data);
    return response.data;
  }
}
