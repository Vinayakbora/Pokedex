import 'package:flutter/material.dart';

class AppColors {
  static Color primaryLightColor = Colors.white;
  static Color primaryDarkColor = Colors.black;
}

class Styles {
  static ThemeData themeData({bool isDarkTheme = false}) {
    return ThemeData(
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      primaryColor: isDarkTheme
          ? AppColors.primaryDarkColor
          : AppColors.primaryLightColor,
      scaffoldBackgroundColor: isDarkTheme
          ? AppColors.primaryDarkColor
          : AppColors.primaryLightColor,
      secondaryHeaderColor: isDarkTheme
          ? AppColors.primaryLightColor
          : AppColors.primaryDarkColor,
      cardColor: isDarkTheme
          ? const Color.fromARGB(0, 0, 0, 0)
          : const Color.fromARGB(121, 255, 255, 255),
      dividerColor: Colors.grey,
      appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme
              ? AppColors.primaryDarkColor
              : AppColors.primaryLightColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: isDarkTheme
                ? AppColors.primaryLightColor
                : AppColors.primaryDarkColor,
          )),
      textTheme: _textTheme(isDarkTheme),
      hintColor: isDarkTheme
                ? AppColors.primaryLightColor
                : AppColors.primaryDarkColor,
      focusColor: isDarkTheme
                ? AppColors.primaryLightColor
                : AppColors.primaryDarkColor,
    );
  }

  static TextTheme _textTheme(bool isDark) {
    return TextTheme(
      headlineSmall: _defaultTextStyle(isDark).copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: _defaultTextStyle(isDark).copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: _defaultTextStyle(isDark).copyWith(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: _defaultTextStyle(isDark).copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: _defaultTextStyle(isDark).copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: _defaultTextStyle(isDark).copyWith(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: _defaultTextStyle(isDark).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: _defaultTextStyle(isDark).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: _defaultTextStyle(isDark).copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: _defaultTextStyle(isDark).copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: _defaultTextStyle(isDark).copyWith(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: _defaultTextStyle(isDark).copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: _defaultTextStyle(isDark).copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: _defaultTextStyle(isDark).copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: _defaultTextStyle(isDark).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle _defaultTextStyle(bool isDark) => TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: isDark ? Colors.white : Colors.black);
}
