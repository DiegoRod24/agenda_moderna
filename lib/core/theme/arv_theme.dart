import 'package:flutter/material.dart';

class ArvColors {
  static const navy = Color(0xFF071522);
  static const navySoft = Color(0xFF0D2032);
  static const gold = Color(0xFFD4AF67);
  static const goldSoft = Color(0xFFE6C98A);
  static const ivory = Color(0xFFF6F1E7);
  static const danger = Color(0xFFD65B5B);
  static const warning = Color(0xFFE1A34A);
  static const success = Color(0xFF4FA37D);
}

ThemeData buildArvTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: ArvColors.gold,
    brightness: Brightness.dark,
    surface: ArvColors.navy,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme.copyWith(
      primary: ArvColors.gold,
      secondary: ArvColors.goldSoft,
      surface: ArvColors.navy,
    ),
    scaffoldBackgroundColor: ArvColors.navy,
    fontFamily: 'serif',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: ArvColors.navySoft,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ArvColors.navySoft,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
