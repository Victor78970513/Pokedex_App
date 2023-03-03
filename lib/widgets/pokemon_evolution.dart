import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonEvolution extends StatelessWidget {
  final String url;
  final Color color;
  final String text;
  const PokemonEvolution(
      {super.key, required this.url, required this.color, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
          ),
          height: 100,
          child: CachedNetworkImage(
            imageUrl: url,
            alignment: Alignment.center,
            // fit: BoxFit.fitHeight,
          ),
        ),
        Text(text)
      ],
    );
  }
}
