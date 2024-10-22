import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon/data/pokemon.dart';
import 'package:flutter_pokemon/providers/pokemon_future_provider.dart';
import 'package:flutter_pokemon/repos/hive_repo.dart';
import 'package:flutter_pokemon/ui/screens/pokemon_details_screen.dart';
import 'package:flutter_pokemon/utlis/extensions/build_context_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  List<Pokemon> favPokemonList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .read(hiveRepoProvider)
          .getAllPokemonFromHive()
          .then((pokemonList) {
        log(pokemonList.length.toString());
        setState(() {
          favPokemonList = pokemonList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final AsyncValue<int> counterProvider = ref.watch(counterStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Pokémon"),
        centerTitle: true,
      ),
      body: favPokemonList.isNotEmpty
          ? ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: favPokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = favPokemonList[index];
                return InkWell(
                  onTap: () {
                      context.navigateToScreen(PokemonDetailsScreen(pokemon: favPokemonList[index]));
                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: pokemon.imageurl!,
                        width: 100,
                        fit: BoxFit.fitWidth,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(pokemon.name!)],
                      ),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            ref
                                .read(hiveRepoProvider)
                                .deletePokemonFromHive(pokemon.id!);
                            setState(() {
                              favPokemonList.remove(pokemon);
                            });
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text("No favourite Pokémon added."),
            ),
    );
  }
}
