import 'package:flutter/material.dart';
import 'package:pokedex/provider/pokemon_provider.dart';
import 'package:pokedex/widgets/widgets.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatefulWidget {
  final Function onNextPage;
  const PokemonList({super.key, required this.onNextPage});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final ScrollController scrollController = ScrollController();
  bool loading = false;

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        widget.onNextPage();
        await Future.delayed(const Duration(seconds: 4));
        if (scrollController.position.pixels + 100 <=
            scrollController.position.maxScrollExtent) {
          scrollController.animateTo(
            scrollController.position.pixels + 120,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Color>> typeGradients = {
      'bug': [const Color(0xff5bb85f), const Color(0xff3bffed)],
      'dark': [const Color(0xff444444), const Color(0xff222222)],
      'dragon': [const Color(0xff171717), const Color(0xfff32e20)],
      'electric': [const Color(0xffffc107), const Color(0xffe8e8e8)],
      'fairy': [const Color(0xffee4c83), const Color(0xfff9b48d)],
      'fighting': [const Color(0xffba160a), const Color(0xffa05038)],
      'fire': [const Color(0xfff44336), const Color(0xffffeb3b)],
      'flying': [const Color(0xff542f95), const Color(0xff98a8f0)],
      'ghost': [const Color(0xff6060b0), const Color(0xffd47fe3)],
      'grass': [const Color(0xff47a44b), const Color(0xff93d7b7)],
      'ground': [const Color(0xffE0C068), const Color(0xff8B5A2B)],
      'ice': [const Color(0xff58c8e0), const Color(0xffd1d1d1)],
      'normal': [const Color(0xffA8A878), const Color(0xffC6C6A7)],
      'poison': [const Color(0xffb058a0), const Color(0xffd1d1d1)],
      'psychic': [const Color(0xfff870a0), const Color(0xffb9b9b9)],
      'rock': [const Color(0xffB8A038), const Color(0xff8B6914)],
      'steel': [const Color(0xffB8B8D0), const Color(0xff787887)],
      'water': [const Color(0xff3899f8), const Color(0xffffffff)],
    };
    final pokedex = Provider.of<PokemonProvider>(context).pokemonDataList;
    final isLoading = Provider.of<PokemonProvider>(context).isLoading;
    final size = MediaQuery.of(context).size;
    if (pokedex.isNotEmpty) {
      return Stack(
        children: [
          ListView.builder(
            controller: scrollController,
            itemCount: pokedex.length,
            itemBuilder: (context, i) {
              final type = pokedex[i].types[0].type.name;
              final gradientColors = typeGradients[type];
              return PokemonCard(
                name: pokedex[i].name,
                id: pokedex[i].id,
                url: pokedex[i].sprites.other!.home.frontDefault,
                gradientColors: gradientColors ??
                    [const Color(0xff6890F0), const Color(0x0ff9d7f5)],
                tipo: pokedex[i].types[0].type.name,
              );
            },
          ),
          if (isLoading)
            Positioned(
              bottom: 40,
              left: size.width * 0.5 - 30,
              child: const _LoadingIcon(),
            ),
        ],
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
      ),
      child: const CircularProgressIndicator(color: Colors.blue),
    );
  }
}
