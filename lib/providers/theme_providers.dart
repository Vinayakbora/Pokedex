import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProviders  extends StateNotifier<bool> {
   ThemeProviders() : super(false);
   final SharedPreferencesAsync asyncPref = SharedPreferencesAsync();

  // void toggleTheme() {
  //   state = !state;
  //   _saveTheme(state);
  // }

  // Future<void> _loadTheme() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  //   state = isDarkMode;
  // }

  // Future<void> _saveTheme(bool isDarkMode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isDarkMode', isDarkMode);
  // }

  Future toggleTheme() async {
    state = !state;
    await asyncPref.setBool('theme', state);
  }

  Future getSavedTheme() async {
    final bool? savedTheme = await asyncPref.getBool('theme');
    state = savedTheme ?? false;
  }
}

final themeProvider = StateNotifierProvider<ThemeProviders, bool>((ref) => ThemeProviders());