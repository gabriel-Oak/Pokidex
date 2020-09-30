import 'package:flutter/material.dart';
import 'package:pokidex/components/rotation_back.dart';
import 'package:pokidex/helpers/models/pokemon_model.dart';

class PokemonsCard extends StatelessWidget {
  final PokemonModel pokemon;
  final Function onTap;

  PokemonsCard({@required this.pokemon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          color: Color(pokemon.cardColor),
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                bottom: -70,
                right: -70,
                child: RotationBack(
                  duration: 3000,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      'assets/back.png',
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                ),
              ),
              Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ],
          ),
        ),
      ),
      onTap: () => onTap(pokemon.apiId),
    );
  }
}
