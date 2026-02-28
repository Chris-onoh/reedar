import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReedarColors {
  static const Color mocha = Color(0xFF5D4037); // Soft dark brown
  static const Color latte = Color(0xFFD7CCC8); // Beige
  static const Color cream = Color(0xFFF5F5DC); // Off-white
  static const Color matcha = Color(0xFFA5D6A7); // Soft green
  static const Color forest = Color(0xFF2E7D32); // Darker green
  static const Color charcoal = Color(0xFF37474F); // Soft black
  static const Color overlay = Color(0x1A5D4037); // Low opacity mocha
  static const Color sage = Color(0xFFAED581); // Soft Light Green
  static const Color error = Color(0xFFE57373); // Soft Red
}

class ReedarTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ReedarColors.mocha,
        primary: ReedarColors.mocha,
        secondary: ReedarColors.forest,
        surface: ReedarColors.cream,
        onSurface: ReedarColors.charcoal,
      ),
      scaffoldBackgroundColor: ReedarColors.cream,
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: ReedarColors.charcoal,
        displayColor: ReedarColors.mocha,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ReedarColors.mocha,
          foregroundColor: ReedarColors.cream,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
