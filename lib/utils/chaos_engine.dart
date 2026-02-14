import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChaosEngine {
  final Random _random = Random();

  // A curated list of distinct fonts to maximize visual variety
  final List<
    TextStyle Function({
      TextStyle? textStyle,
      Color? color,
      Color? decorationColor,
      Color? backgroundColor,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextBaseline? textBaseline,
      double? height,
      Locale? locale,
      Paint? foreground,
      Paint? background,
      List<Shadow>? shadows,
      List<FontFeature>? fontFeatures,
      TextDecoration? decoration,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
    })
  >
  _fonts = [
    GoogleFonts.roboto,
    GoogleFonts.lato,
    GoogleFonts.openSans,
    GoogleFonts.montserrat,
    GoogleFonts.oswald,
    GoogleFonts.raleway,
    GoogleFonts.merriweather,
    GoogleFonts.playfairDisplay,
    GoogleFonts.nunito,
    GoogleFonts.rubik,
    GoogleFonts.poppins,
    GoogleFonts.lora,
    GoogleFonts.ptSerif,
    GoogleFonts.notoSans,
    GoogleFonts.notoSerif,
    GoogleFonts.workSans,
    GoogleFonts.arvo,
    GoogleFonts.breeSerif,
    GoogleFonts.vt323, // Pixel
    GoogleFonts.pressStart2p, // Pixel
    GoogleFonts.bangers, // Comic
    GoogleFonts.creepster, // Horror
    GoogleFonts.permanentMarker, // Handwriting
    GoogleFonts.shadowsIntoLight, // Handwriting
    GoogleFonts.pacifico, // Cursive
    GoogleFonts.dancingScript, // Cursive
    GoogleFonts.indieFlower, // Handwriting
    GoogleFonts.amaticSc, // Handwriting
    GoogleFonts.cinzel, // Decorative
    GoogleFonts.abrilFatface, // Display
    GoogleFonts.lobster, // Display
    GoogleFonts.righteous, // Display
    GoogleFonts.fredoka, // Display
    GoogleFonts.monoton, // Display
    GoogleFonts.audiowide, // Tech
    GoogleFonts.orbitron, // Tech
    GoogleFonts.specialElite, // Typewriter
    GoogleFonts.courierPrime, // Monospace
    GoogleFonts.firaCode, // Monospace
    GoogleFonts.sourceCodePro, // Monospace
    GoogleFonts.rockSalt, // Handwriting
    GoogleFonts.sacramento, // Cursive
    GoogleFonts.tangerine, // Cursive
    GoogleFonts.greatVibes, // Cursive
    GoogleFonts.ultra, // Heavy Display
    GoogleFonts.shrikhand, // Heavy Display
    GoogleFonts.bungee, // Display
    GoogleFonts.bungeeShade, // Display
    GoogleFonts.bungeeInline, // Display
    GoogleFonts.cabinSketch, // Sketch
    GoogleFonts.frederickaTheGreat, // Sketch
    GoogleFonts.fingerPaint, // Sketch
    GoogleFonts.rye, // Western
    GoogleFonts.sancreek, // Western
    GoogleFonts.unifrakturMaguntia, // Gothic
    GoogleFonts.blackOpsOne, // Stencil
    GoogleFonts.wallpoet, // Stencil
    GoogleFonts.syneMono, // Monospace Art
    GoogleFonts.dmSerifDisplay, // Serif
    GoogleFonts.majorMonoDisplay, // Weird
    GoogleFonts.sixCaps, // Condensed
    GoogleFonts.aboreto, // Decorative
    GoogleFonts.silkscreen, // Pixel
  ];

  Color generateRandomColor({double opacity = 1.0}) {
    // Generate high contrast, stimulating colors. Avoid pastels.
    // Bias towards neon/cyberpunk colors
    int r = _random.nextInt(256);
    int g = _random.nextInt(256);
    int b = _random.nextInt(256);

    // Ensure brightness is sufficient for dark mode or vice versa.
    // For now, simple random.
    return Color.fromRGBO(r, g, b, opacity);
  }

  Color generateStimulatingColor() {
    List<Color> palette = [
      Colors.cyanAccent,
      Colors.limeAccent,
      Colors.pinkAccent,
      Colors.amberAccent,
      Colors.lightBlueAccent,
      Colors.tealAccent,
      Colors.purpleAccent,
      Colors.deepOrangeAccent,
      Colors.redAccent,
      Colors.white,
      Colors.yellowAccent,
    ];
    return palette[_random.nextInt(palette.length)];
  }

  TextStyle generateChaoticStyle({
    double baseSize = 20.0,
    double chaosFactor = 1.0,
  }) {
    var fontGetter = _fonts[_random.nextInt(_fonts.length)];

    double size =
        baseSize +
        (_random.nextDouble() * 20 - 10) * chaosFactor; // +/- 10 variation
    if (size < 12) size = 12;

    FontWeight weight = _random.nextBool()
        ? FontWeight.bold
        : FontWeight.normal;
    FontStyle style = _random.nextBool() ? FontStyle.italic : FontStyle.normal;

    // 1 in 10 chance of background color highlight
    Color? bgColor = _random.nextDouble() < (0.1 * chaosFactor)
        ? generateStimulatingColor().withOpacity(0.3)
        : null;
    Color fgColor = generateStimulatingColor();

    return fontGetter(
      fontSize: size,
      fontWeight: weight,
      fontStyle: style,
      color: fgColor,
      backgroundColor: bgColor,
      letterSpacing:
          (_random.nextDouble() * 4 - 1) *
          chaosFactor, // Tight or wide tracking
    );
  }

  double generateRotation(double chaosFactor) {
    // Returns radians.
    // chaosFactor 1.0 might mean +/- 5 degrees
    double maxDegrees = 5.0 * chaosFactor;
    double degrees = (_random.nextDouble() * 2 * maxDegrees) - maxDegrees;
    return degrees * (pi / 180.0);
  }
}
