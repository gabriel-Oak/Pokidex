import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PokemonStatModel extends Equatable {
  final int baseStat;
  final int effort;
  final String name;

  PokemonStatModel({
    @required this.baseStat,
    @required this.effort,
    @required this.name,
  });

  factory PokemonStatModel.fromMap(Map map) {
    return PokemonStatModel(
      baseStat: map['baseStat'],
      effort: map['effort'],
      name: map['name'],
    );
  }

  factory PokemonStatModel.fromApi(Map map) {
    return PokemonStatModel(
      baseStat: map['base_stat'],
      effort: map['effort'],
      name: map['stat']['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baseStat': baseStat,
      'name': name,
      'effort': effort,
    };
  }

  static Map<String, dynamic> mapTransform(Map map) {
    return {
      'baseStat': map['base_stat'],
      'effort': map['effort'],
      'name': map['stat']['name'],
    };
  }

  List<Object> get props => [baseStat, effort, name];
}
