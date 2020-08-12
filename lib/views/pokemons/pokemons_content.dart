import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_state.dart';

class PokemonsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonsBloc, PokemonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Pokídex',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(
                  child: Container(
                    height: 1,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
            child: state.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state.pokemons.length > 0
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: state.pokemons.length,
                        itemBuilder: (contex, index) => Container(),
                      )
                    : Center(
                        child: Text('Nenhum pokemon :('),
                      ),
          ),
          backgroundColor: Colors.blue,
        );
      },
    );
  }
}
