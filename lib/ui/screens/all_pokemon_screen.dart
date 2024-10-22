import 'package:flutter/material.dart';
import 'package:flutter_pokemon/data/pokemon.dart';
import 'package:flutter_pokemon/providers/pokemon_future_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_pokemon/providers/theme_providers.dart';
import 'package:flutter_pokemon/ui/screens/favourite_screen.dart';
import 'package:flutter_pokemon/ui/screens/pokemon_details_screen.dart';
import 'package:flutter_pokemon/utlis/extensions/build_context_extension.dart';
import 'package:flutter_pokemon/utlis/helpers/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllPokemonScreen extends ConsumerWidget {
  const AllPokemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> pokemonList = ref.watch(pokeonFutureProvider);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pokedex'),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      context.navigateToScreen(const FavouriteScreen());
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.lightbulb_rounded),
                    onPressed: () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        body: pokemonList.when(data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2 / 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.navigateToScreen(PokemonDetailsScreen(pokemon: data[index]));
                    },
                    child: Card(
                        color: Helpers.getPokemonCardColour(
                            pokemonType: data[index].typeofpokemon?.first ?? ""),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Image.asset(
                                'images/pokeball.png',
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 10,
                              child: Hero(
                                tag: data[index].id!,
                                child: CachedNetworkImage(
                                  imageUrl: data[index].imageurl!,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 10,
                                top: 20,
                                child: Text(
                                  data[index].name!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Positioned(
                                left: 10,
                                top: 50,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10),
                                      child: Text(
                                        data[index].typeofpokemon!.first,
                                        style:
                                            const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        )),
                  );
                }),
          );
        }, error: (error, stk) {
          return Center(
            child: Text(error.toString()),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
