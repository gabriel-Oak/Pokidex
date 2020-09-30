import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokidex/helpers/models/pokemon_stat_model.dart';
import 'package:pokidex/helpers/models/pokemon_type_model.dart';
import 'package:pokidex/helpers/utils/poke_colors.dart';

class PokemonModel extends Equatable {
  final int apiId;
  final String name;
  final int heigth;
  final int weight;
  final String img;
  final List types;
  final List abilities;
  final int cardColor;
  final List stats;

  PokemonModel({
    @required this.apiId,
    @required this.name,
    @required this.heigth,
    @required this.weight,
    @required this.img,
    @required this.types,
    @required this.abilities,
    @required this.cardColor,
    @required this.stats,
  });

  factory PokemonModel.fromStorage(Map map) {
    final List t = json
        .decode(map['types'])
        .map((type) => PokemonTypeModel.fromMap(type))
        .toList();

    return PokemonModel(
      apiId: map['apiId'],
      name: map['name'],
      heigth: map['heigth'],
      weight: map['weight'],
      img: map['img'],
      cardColor: int.parse(pokeColor[t.where((e) => e.slot == 1).first.name]
          .replaceAll(RegExp(r'#'), '0xFF')),
      types: t,
      abilities: json.decode(map['abilities']),
      stats: json
          .decode(map['stats'])
          .map((e) => PokemonStatModel.fromMap(e))
          .toList(),
    );
  }

  factory PokemonModel.fromApi(Map map) {
    final List<String> splitedName = map['name'].split(' ');
    final List t =
        map['types'].map((type) => PokemonTypeModel.fromApi(type)).toList();

    return PokemonModel(
      apiId: map['id'],
      heigth: map['heigth'],
      weight: map['weight'],
      img: map['sprites']['front_default'],
      types: t,
      abilities: map['abilities']
          .map((ability) => ability['ability']['name'])
          .toList(),
      name: splitedName
          .map(
              (segment) => '${segment[0].toUpperCase()}${segment.substring(1)}')
          .join(' '),
      cardColor: int.parse(
        pokeColor[t.where((e) => e.slot == 1).first.name]
            .replaceAll(RegExp(r'#'), '0xFF'),
      ),
      stats: map['stats'].map((e) => PokemonStatModel.fromApi(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'apiId': apiId,
      'name': name,
      'heigth': heigth,
      'weight': weight,
      'img': img,
      'types': json.encode(types.map((type) => type.toMap()).toList()),
      'stats': json.encode(stats.map((e) => e.toMap()).toList()),
      'abilities': json.encode(abilities),
    };
  }

  List<Object> get props => [
        apiId,
        name,
        heigth,
        weight,
        img,
        types,
        stats,
        abilities,
      ];
}
