import 'package:flutter/material.dart';
import 'package:flutter_pokemon/providers/theme_providers.dart';
import 'package:flutter_pokemon/repos/hive_repo.dart';
import 'package:flutter_pokemon/themes/styles.dart';
import 'package:flutter_pokemon/ui/screens/all_pokemon_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveRepo().registerAdapter();

  runApp(const ProviderScope(child: PokedexApp()));
}

class PokedexApp extends ConsumerStatefulWidget {
  const PokedexApp({super.key});

  @override
  ConsumerState<PokedexApp> createState() => _PokedexAppState();
}

class _PokedexAppState extends ConsumerState<PokedexApp> {

@override
void initState() {
  super.initState();
  Future.microtask(() async {
    await ref.read(themeProvider.notifier).getSavedTheme();
  });
}

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(themeProvider);
    return  MaterialApp(
      theme: Styles.themeData(isDarkTheme: isDarkTheme),
      home: const AllPokemonScreen(),
    );
  }
}
