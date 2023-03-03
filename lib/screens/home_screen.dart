import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokemon_provider.dart';

import 'package:pokedex/widgets/pokemon_list.dart';
import 'package:pokedex/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: PokemonList(
              onNextPage: () => pokemonProvider.getPokeApi(),
            ),
          ),
        ],
      )),
    );
  }
}
