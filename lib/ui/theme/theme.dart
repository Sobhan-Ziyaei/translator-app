import 'package:flutter/material.dart';
import 'package:translator_app/gen/fonts.gen.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: const TextTheme(
      labelMedium: TextStyle(
        fontFamily: FontFamily.irs,
        fontSize: 20,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontFamily: FontFamily.irs,
        fontSize: 12,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontFamily: FontFamily.irs,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: FontFamily.irs,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamily.irs,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamily.irs,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    ),
  );
}
