import 'package:flutter/material.dart';

abstract final class AppTheme {
  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF040404),
    ),
    useMaterial3: true,
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Color(0xFF040404),
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF040404),
      foregroundColor: Color(0xFFFFFFFF),
    ),
    useMaterial3: true,
  );
}
