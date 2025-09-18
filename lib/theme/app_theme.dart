import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    const background = Colors.white;
    const foreground = Colors.black;
    final colorScheme = base.colorScheme.copyWith(
      brightness: Brightness.light,
      background: background,
      surface: background,
      onBackground: foreground,
      onSurface: foreground,
      primary: const Color(0xFF4CAF50),
    );
    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: foreground,
        centerTitle: true,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: foreground,
        displayColor: foreground,

      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    const background = Color(0xFF0E0F13); // near-black
    const foreground = Colors.white;
    final colorScheme = base.colorScheme.copyWith(
      brightness: Brightness.dark,
      background: background,
      surface: background,
      onBackground: foreground,
      onSurface: foreground,
      primary: const Color(0xFF80CBC4),
    );
    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: foreground,
        centerTitle: true,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: foreground,
        displayColor: foreground,
      ),
    );
  }
}
