import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/data/pokemon.dart';
import 'package:flutter_pokemon/repos/hive_repo.dart';
import 'package:flutter_pokemon/ui/widgets/rotating_widget.dart';
import 'package:flutter_pokemon/utlis/extensions/build_context_extension.dart';
import 'package:flutter_pokemon/utlis/helpers/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonDetailsScreen extends ConsumerStatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokemon});
  final Pokemon pokemon;

  @override
  ConsumerState<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends ConsumerState<PokemonDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.getPokemonCardColour(
          pokemonType: widget.pokemon.typeofpokemon!.first),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            widget.pokemon.name!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(hiveRepoProvider).addPokemonToHive(widget.pokemon);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: context.getWidth(percentage: 0.5) - 125,
            child: const RotatingImageWidget()
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              height: context.getHeight(percentage: 0.58),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.pokemon.xdescription!),
                    const SizedBox(
                      height: 10,
                    ),
                    PokemonDetailsRowWidget(
                        title: 'Type',
                        data: widget.pokemon.typeofpokemon!.join(',')),
                    PokemonDetailsRowWidget(
                        title: 'Height', data: widget.pokemon.height!),
                    PokemonDetailsRowWidget(
                        title: 'Weight', data: widget.pokemon.weight!),
                    PokemonDetailsRowWidget(
                        title: 'Speed', data: widget.pokemon.speed.toString()),
                    PokemonDetailsRowWidget(
                        title: 'Attack',
                        data: widget.pokemon.attack.toString()),
                    PokemonDetailsRowWidget(
                        title: 'Defense',
                        data: widget.pokemon.defense.toString()),
                    PokemonDetailsRowWidget(
                        title: 'Weakness',
                        data: widget.pokemon.weaknesses!.join(',')),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: context.getWidth(percentage: 0.5) - 125,
            child: Hero(
              tag: widget.pokemon.id!,
              child: CachedNetworkImage(
                imageUrl: widget.pokemon.imageurl!,
                width: 250,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonDetailsRowWidget extends StatelessWidget {
  const PokemonDetailsRowWidget({
    super.key,
    required this.title,
    required this.data,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: context.getWidth(percentage: 0.3),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            width: 230,
            child: Text(
              data,
              maxLines: 2,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
