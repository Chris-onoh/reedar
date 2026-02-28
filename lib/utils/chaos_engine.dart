import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ChaosEngine {
  final Random _random = Random();

  // A curated list of distinct, nature-friendly fonts.
  // Removed sci-fi fonts, kept handwriting and serifs for "organic" feel.
  final List<
    TextStyle Function({
      TextStyle? textStyle,
      Color? color,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextDecoration? decoration,
      TextDecorationStyle? decorationStyle,
      Color? decorationColor,
    })
  >
  _fonts = [
    GoogleFonts.outfit,
    GoogleFonts.quicksand,
    GoogleFonts.lora,
    GoogleFonts.merriweather,
    GoogleFonts.patrickHand,
    GoogleFonts.indieFlower,
    GoogleFonts.dosis,
    GoogleFonts.nunito,
    GoogleFonts.raleway,
    GoogleFonts.playfairDisplay,
    GoogleFonts.libreBaskerville,
    GoogleFonts.crimsonText,
    GoogleFonts.dmSans,
    GoogleFonts.josefinSans,
    GoogleFonts.comfortaa,
    GoogleFonts.amaticSc,
    GoogleFonts.caveat,
    GoogleFonts.shadowsIntoLight,
    GoogleFonts.dancingScript,
    GoogleFonts.abrilFatface, // Bold but elegant
    GoogleFonts.poppins,
  ];

  // Subset for "Dysfluent" / Active Inference (Harder to read, but organic)
  late final List<
    TextStyle Function({
      TextStyle? textStyle,
      Color? color,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextDecoration? decoration,
      TextDecorationStyle? decorationStyle,
      Color? decorationColor,
    })
  >
  _dysfluentFonts = [
    GoogleFonts.indieFlower,
    GoogleFonts.amaticSc,
    GoogleFonts.caveat,
    GoogleFonts.shadowsIntoLight,
    GoogleFonts.patrickHand,
    GoogleFonts.dancingScript,
    GoogleFonts.gloriaHallelujah,
    GoogleFonts.permanentMarker, // Slightly heavy, but hand-written
  ];

  Color generateRandomColor({double opacity = 1.0}) {
    // Earthen tones
    List<Color> palette = [
      ReedarColors.mocha,
      ReedarColors.forest,
      ReedarColors.charcoal,
      const Color(0xFF795548), // Brown
      const Color(0xFF5D4037), // Dark Brown
      const Color(0xFF388E3C), // Green
      const Color(0xFF455A64), // Blue Grey
    ];
    return palette[_random.nextInt(palette.length)].withOpacity(opacity);
  }

  // Updated to return Nature/Coffee colors instead of Neon
  Color generateStimulatingColor() {
    List<Color> palette = [
      ReedarColors.mocha,
      ReedarColors.forest,
      ReedarColors.charcoal,
      ReedarColors.mocha.withOpacity(0.8),
      ReedarColors.forest.withOpacity(0.8),
      ReedarColors.charcoal.withOpacity(0.8),
      const Color(0xFF8D6E63), // Brown 400
      const Color(0xFF4E342E), // Brown 800
      const Color(0xFF2E7D32), // Green 800
      const Color(0xFF1B5E20), // Green 900
      const Color(0xFF37474F), // Blue Grey 800
      const Color(0xFF263238), // Blue Grey 900
    ];
    return palette[_random.nextInt(palette.length)];
  }

  Color generateChaosBackgroundColor() {
    // Soft Highlights (Matcha/Latte)
    List<Color> palette = [
      ReedarColors.matcha,
      ReedarColors.latte,
      ReedarColors.sage,
      Colors.orange[100]!,
      Colors.brown[100]!,
    ];
    return palette[_random.nextInt(palette.length)].withOpacity(
      0.3 + _random.nextDouble() * 0.2,
    );
  }

  TextStyle generateChaoticStyle({
    double baseSize = 20.0,
    double chaosFactor = 1.0,
  }) {
    var fontGetter = _fonts[_random.nextInt(_fonts.length)];

    double size =
        baseSize +
        (_random.nextDouble() * 8 - 4) *
            chaosFactor; // Reduced variance from +/- 10 to +/- 4 for "calm"
    if (size < 14) size = 14;

    FontWeight weight = _random.nextDouble() < 0.3
        ? FontWeight.bold
        : FontWeight.normal; // Less bold frequency
    FontStyle style = _random.nextDouble() < 0.2
        ? FontStyle.italic
        : FontStyle.normal;

    // Background highlight chance
    Color? bgColor = _random.nextDouble() < (0.05 * chaosFactor)
        ? generateChaosBackgroundColor()
        : null;
    Color fgColor = generateStimulatingColor();

    final double letterSpacing =
        (_random.nextDouble() * 2 - 0.5) * chaosFactor; // Reverted to -0.5

    return fontGetter(
      fontSize: size,
      fontWeight: weight,
      fontStyle: style,
      color: fgColor,
      backgroundColor: bgColor,
      letterSpacing: letterSpacing,
    );
  }

  // Active Inference: Retains variability but with organic feel
  TextStyle generateActiveInferenceStyle({
    double baseSize = 20.0,
    double chaosInternal = 1.0,
  }) {
    var fontGetter = _random.nextDouble() < 0.6
        ? _dysfluentFonts[_random.nextInt(_dysfluentFonts.length)]
        : _fonts[_random.nextInt(_fonts.length)];

    double size = baseSize + (_random.nextDouble() * 6 - 3) * chaosInternal;
    if (size < 16) size = 16;

    Color fgColor = generateStimulatingColor();
    double letterSpacing = generateChaoticSpacing(chaosInternal);
    double wordSpacing = (_random.nextDouble() * 3) * chaosInternal;

    return fontGetter(
      fontSize: size,
      fontWeight: _random.nextBool() ? FontWeight.bold : FontWeight.normal,
      color: fgColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      backgroundColor: _random.nextDouble() < (0.05 * chaosInternal)
          ? generateChaosBackgroundColor()
          : null,
      decoration: _random.nextDouble() < (0.02 * chaosInternal)
          ? TextDecoration.underline
          : TextDecoration.none,
      decorationColor: fgColor,
      decorationStyle:
          TextDecorationStyle.solid, // Removed 'wavy' for cleaner look
    );
  }

  // Rotation: Reduced magnitude for "Soft" feel unless high chaos
  double generateRotation(double chaosFactor) {
    if (chaosFactor < 0.5) return 0.0;
    double maxDegrees = 2.0 * chaosFactor; // Reduced from 5.0
    double degrees = (_random.nextDouble() * 2 * maxDegrees) - maxDegrees;
    return degrees * (pi / 180.0);
  }

  double generateActiveInferenceRotation() {
    double minDegrees = 1.0;
    double maxDegrees = 3.0; // Reduced from 7.0

    double degrees =
        minDegrees + _random.nextDouble() * (maxDegrees - minDegrees);

    if (_random.nextBool()) {
      degrees = -degrees;
    }

    return degrees * (pi / 180.0);
  }

  double generateChaoticSpacing(double chaosFactor) {
    return (_random.nextDouble() * 3 - 1.0) * chaosFactor;
  }
}
