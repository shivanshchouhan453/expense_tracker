import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF2D2D2D);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  static const Color lightBg = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF757575);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF00D4FF); // Cyan
  static const Color gradientEnd = Color(0xFFFF006B); // Magenta
  static const Color gradientGreen = Color(0xFF00E676);
  static const Color accentGreen = Color(0xFF1DE9B6);

  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF00D4FF), // Cyan
    Color(0xFF1DE9B6), // Teal
    Color(0xFF00E676), // Green
    Color(0xFFFFCA28), // Amber
    Color(0xFFFF6B6B), // Red
  ];

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: gradientStart,
      scaffoldBackgroundColor: darkBg,
      appBarTheme: const AppBarTheme(backgroundColor: darkBg, elevation: 0),
      colorScheme: const ColorScheme.dark(
        primary: gradientStart,
        secondary: accentGreen,
        surface: darkCard,
        error: Color(0xFFFF5252),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: darkText,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        displayMedium: TextStyle(
          color: darkText,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
        titleLarge: TextStyle(
          color: darkText,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(color: darkText, fontSize: 16),
        bodyMedium: TextStyle(color: darkTextSecondary, fontSize: 14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkCard),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkCard),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gradientStart, width: 2),
        ),
      ),
    );
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: gradientStart,
      scaffoldBackgroundColor: lightBg,
      appBarTheme: const AppBarTheme(backgroundColor: lightBg, elevation: 0),
      colorScheme: const ColorScheme.light(
        primary: gradientStart,
        secondary: accentGreen,
        surface: lightCard,
        error: Color(0xFFFF5252),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: lightText,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        displayMedium: TextStyle(
          color: lightText,
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),
        titleLarge: TextStyle(
          color: lightText,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        bodyLarge: TextStyle(color: lightText, fontSize: 16),
        bodyMedium: TextStyle(color: lightTextSecondary, fontSize: 14),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gradientStart, width: 2),
        ),
      ),
    );
  }
}
