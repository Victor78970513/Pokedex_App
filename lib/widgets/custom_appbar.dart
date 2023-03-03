import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xff77A7C1),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Your Pokedex',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const TextField(
              autofocus: false,
              decoration: InputDecoration(
                  hintText: 'Search Pokemon, Ability...',
                  icon: Icon(Icons.search)),
            ),
          )
        ],
      ),
    );
  }
}
