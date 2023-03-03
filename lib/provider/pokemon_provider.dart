import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_model.dart';

class PokemonProvider extends ChangeNotifier {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  int offset = 0;
  bool _isLoading = false;
  int _index = 1;

  List<Result> pokemons1 = [];
  List<PokemonPokeApi> pokemonDataList = [];
  PokemonProvider() {
    getPokeApi();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int get index => _index;
  set index(int value) {
    _index = value;
    notifyListeners();
  }

  getPokeApi() async {
    isLoading = true;
    pokemons1.clear();
    final url = Uri.parse('$baseUrl?offset=$offset&limit=9');
    final response = await http.get(url);
    final pokemonPath = AllPokemon.fromJson(response.body);
    pokemons1 = pokemonPath.results;
    offset += 9;
    for (var pokemonAnia in pokemons1) {
      final pokemonUrl = Uri.parse(pokemonAnia.url);
      final pokemonResponse = await http.get(pokemonUrl);
      final pokemonData = PokemonPokeApi.fromJson(pokemonResponse.body);
      pokemonDataList.add(pokemonData);
    }
    isLoading = false;
    notifyListeners();
  }
}
