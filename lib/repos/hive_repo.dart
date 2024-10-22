import 'package:flutter_pokemon/data/pokemon.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class HiveRepo {
  final pokemonBoxName = 'pokemonBox';

  void registerAdapter() {
    Hive.registerAdapter(PokemonAdapter());
  }

  Future addPokemonToHive(Pokemon pokemon) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      await pokemonBox.put(pokemon.id!, pokemon);
      Hive.close();
    } else {
      throw Exception('Box is not open');
    }
  }

  Future deletePokemonFromHive(String id) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      await pokemonBox.delete(id);
    } else {
      throw Exception('Box is not open');
    }
  }

  Future<List<Pokemon>> getAllPokemonFromHive() async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      return pokemonBox.values.toList();
    } else {
      throw Exception('Box is not open');
    }
  }

  Future<Pokemon> getPokemonFromHive(String id) async {
    final pokemonBox = await Hive.openBox<Pokemon>(pokemonBoxName);
    if (pokemonBox.isOpen) {
      return pokemonBox.get(id)!;
    } else {
      throw Exception('Box is not open');
    }
  }
}

final hiveRepoProvider = Provider<HiveRepo>((ref)=> HiveRepo());
