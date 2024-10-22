import 'dart:convert';
import 'dart:developer';

import 'package:flutter_pokemon/data/pokemon.dart';
import 'package:flutter_pokemon/network/dio_client.dart';
import 'package:flutter_pokemon/utlis/helpers/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemnonRepo {
  final Ref ref;

  PokemnonRepo({required this.ref});

  Future<List<Pokemon>> getAllPokemons() async {
    try {
      final response = await ref.read(dioProvider).get(POKEMON_API_URL);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.data);
        final List<Pokemon> pokemonList = decodedJson
            .map<Pokemon>((pokemon) => Pokemon.fromJson(pokemon))
            .toList();
        log(pokemonList.first.name!);
        return pokemonList;
      } else {
        throw Exception('Failed to load pokemon');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

final pokemonRepoProvider = Provider((ref) => PokemnonRepo(ref: ref));
