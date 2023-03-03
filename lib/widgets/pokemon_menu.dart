import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonMenu extends StatelessWidget {
  final int index;
  final String text;

  const PokemonMenu({super.key, required this.index, required this.text});
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Container(
              height: 25,
              child: Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            onTap: () {
              pokemonProvider.index = index;
            },
          ),
        ],
      ),
    );
  }
}
