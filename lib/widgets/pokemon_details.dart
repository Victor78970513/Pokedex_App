import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex/widgets/pokemon_evolution.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/provider/pokemon_provider.dart';
import 'package:pokedex/widgets/pokemon_menu.dart';

class PokemonDetails extends StatelessWidget {
  final String url;
  final List<Color> color;
  final int pokeId;
  const PokemonDetails({
    super.key,
    required this.url,
    required this.color,
    required this.pokeId,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final pokedex = Provider.of<PokemonProvider>(context).pokemonDataList;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: color,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height / 2.5,
              ),
              Expanded(
                child: Container(
                  height: height / 3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(50)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          PokemonMenu(index: 1, text: 'Stats'),
                          PokemonMenu(index: 2, text: ' About & Moves'),
                          PokemonMenu(index: 3, text: 'Evolutions')
                        ],
                      ),
                      PokemonInformation(
                        color: color.first,
                        posicion: pokeId,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                    ),
                    Text(
                      pokedex[pokeId - 1].name,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.star_border_outlined),
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 310,
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: url,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PokemonInformation extends StatelessWidget {
  final int posicion;
  final Color color;
  const PokemonInformation(
      {super.key, required this.posicion, required this.color});
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context).index;
    final pokemonData = Provider.of<PokemonProvider>(context).pokemonDataList;
    List primeroPoke = [];
    List segundoPoke = [];
    List tercerPoke = [];
    for (int i = 1; i < pokemonData.length; i = i + 3) {
      primeroPoke.add(i);
    }
    for (int i = 2; i < pokemonData.length; i = i + 3) {
      segundoPoke.add(i);
    }
    for (int i = 3; i < pokemonData.length; i = i + 3) {
      tercerPoke.add(i);
    }
    if (pokemonProvider == 1) {
      return Expanded(
        child: ListView.builder(
          itemCount: pokemonData[posicion].stats.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pokemonData[posicion].stats[i].stat.name),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        height: 10,
                        width: 250,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10)),
                        height: 10,
                        width:
                            pokemonData[posicion].stats[i].baseStat.toDouble(),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
    } else if (pokemonProvider == 2) {
      return Expanded(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            var textStyle = const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            );
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Height:   ${pokemonData[posicion].height}',
                        style: textStyle,
                      ),
                      Text(
                        'Widht:  ${pokemonData[posicion].weight}',
                        style: textStyle,
                      ),
                      Text(
                        'Abilities: ${pokemonData[posicion].abilities.map((ability) => ability.ability.name).join(", ")}',
                        style: textStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ' Types: ${pokemonData[posicion].types.map((tipo) => tipo.type.name).join(', ')}',
                        style: textStyle,
                      ),
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                pokemonData[posicion - 1].sprites.frontDefault,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: CachedNetworkImage(
                              imageUrl:
                                  pokemonData[posicion - 1].sprites.backDefault,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                            ),
                          ),
                          CachedNetworkImage(
                            imageUrl:
                                pokemonData[posicion - 1].sprites.backShiny,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else if (pokemonProvider == 3) {
      return Expanded(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            if (primeroPoke.contains(pokemonData[posicion - 1].id)) {
              // return Text(
              //     'SI EXISTE El ID EN PRIMERO POKE ${pokemonData[posicion].id}');
              return Row(
                children: [
                  PokemonEvolution(
                      url: pokemonData[posicion - 1]
                          .sprites
                          .other!
                          .home
                          .frontDefault,
                      color: color,
                      text: pokemonData[posicion - 1].name),
                  PokemonEvolution(
                      url: pokemonData[posicion]
                          .sprites
                          .other!
                          .home
                          .frontDefault,
                      color: color,
                      text: pokemonData[posicion].name),
                  PokemonEvolution(
                      url: pokemonData[posicion + 1]
                          .sprites
                          .other!
                          .home
                          .frontDefault,
                      color: color,
                      text: pokemonData[posicion + 1].name)
                ],
              );
            } else if (segundoPoke.contains(pokemonData[posicion - 1].id)) {
              return Row(
                children: [
                  PokemonEvolution(
                      url: pokemonData[posicion - 2]
                          .sprites
                          .other!
                          .home
                          .frontDefault,
                      color: color,
                      text: pokemonData[posicion - 2].name),
                  PokemonEvolution(
                      url: pokemonData[posicion - 1]
                          .sprites
                          .other!
                          .home
                          .frontDefault,
                      color: color,
                      text: pokemonData[posicion - 1].name),
                  PokemonEvolution(
                      url: pokemonData[posicion]
                          .sprites
                          .other!
                          .home
                          .frontDefault,
                      color: color,
                      text: pokemonData[posicion].name)
                ],
              );
            } else if (tercerPoke.contains(pokemonData[posicion - 1].id)) {
              return Row(
                children: [
                  PokemonEvolution(
                    url: pokemonData[posicion - 3]
                        .sprites
                        .other!
                        .home
                        .frontDefault,
                    color: color,
                    text: pokemonData[posicion - 3].name,
                  ),
                  PokemonEvolution(
                    url: pokemonData[posicion - 2]
                        .sprites
                        .other!
                        .home
                        .frontDefault,
                    color: color,
                    text: pokemonData[posicion - 2].name,
                  ),
                  PokemonEvolution(
                    url: pokemonData[posicion - 1]
                        .sprites
                        .other!
                        .home
                        .frontDefault,
                    color: color,
                    text: pokemonData[posicion - 1].name,
                  )
                ],
              );
            } else {
              return Text(
                  'SI EXISTE El ID ${pokemonData[posicion].id} NO EXISTE');
            }
          },
        ),
      );
    } else {
      return const Center(
        child: Text('No Existe La pestana'),
      );
    }
  }
}
