// To parse this JSON data, do
//
//     final allPokemon = allPokemonFromMap(jsonString);

import 'dart:convert';

class AllPokemon {
  AllPokemon({
    required this.results,
  });

  List<Result> results;

  factory AllPokemon.fromJson(String str) =>
      AllPokemon.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllPokemon.fromMap(Map<String, dynamic> json) => AllPokemon(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Result {
  Result({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}
