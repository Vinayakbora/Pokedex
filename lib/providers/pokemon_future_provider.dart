import 'package:flutter_pokemon/data/pokemon.dart';
import 'package:flutter_pokemon/repos/pokemnon_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokeonFutureProvider = FutureProvider<List<Pokemon>>((ref) async {
 return await ref.watch(pokemonRepoProvider).getAllPokemons();
});


final counterStreamProvider = StreamProvider.autoDispose.family<int, int>((ref, counterStart) async* {
  int counter = counterStart;
  while (counter < 20) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield counter++;
  }
});
