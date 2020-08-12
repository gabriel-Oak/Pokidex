import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokemonsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPokemons extends PokemonsEvent {
  final int offSet;

  GetPokemons({this.offSet});
}

class SetPokemons extends PokemonsEvent {
  final Map pagination;

  SetPokemons({@required this.pagination});
}
