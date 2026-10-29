import 'package:flutter/material.dart';

const Color tokoGreen = Color(0xFF03AC0E);
const Color tokoDark = Color(0xFF028A0B);
const Color tokoOrange = Color(0xFFFF5722);
const Color bgGrey = Color(0xFFF3F4F5);
const Color textGrey = Color(0xFF6D7588);

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: false,
    primaryColor: tokoGreen,
    scaffoldBackgroundColor: bgGrey,
    colorScheme: const ColorScheme.light(
      primary: tokoGreen,
      secondary: tokoGreen,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: tokoGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: tokoGreen,
        side: const BorderSide(color: tokoGreen),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
