import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';

class PokemonsCard extends StatelessWidget {
  final Pokemon pokemon;
  final Function onTap;

  PokemonsCard({@required this.pokemon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(pokemon.cardColor),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              pokemon.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: pokemon.types
                        .map(
                          (type) => Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(30),
                                  right: Radius.circular(30),
                                ),
                                color: Color(type.color),
                              ),
                              child: Text(
                                type.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Expanded(
                    child: Hero(
                      tag: 'image-${pokemon.apiId}',
                      child: FadeInImage.assetNetwork(
                        image: pokemon.img,
                        placeholder: 'assets/pokiball.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => onTap(pokemon.apiId),
    );
  }
}
