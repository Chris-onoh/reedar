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
    // 1. Font Loader & Google Fonts Integration - Extensive collection
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
    GoogleFonts.arvo, GoogleFonts.breeSerif,
    // 2. Dysfluent Font Collection Curation candidates
    GoogleFonts.vt323,
    GoogleFonts.pressStart2p,
    GoogleFonts.bangers,
    GoogleFonts.creepster,
    GoogleFonts.permanentMarker,
    GoogleFonts.shadowsIntoLight,
    GoogleFonts.pacifico,
    GoogleFonts.dancingScript,
    GoogleFonts.indieFlower,
    GoogleFonts.amaticSc,
    GoogleFonts.cinzel,
    GoogleFonts.abrilFatface,
    GoogleFonts.lobster,
    GoogleFonts.righteous,
    GoogleFonts.fredoka,
    GoogleFonts.monoton,
    GoogleFonts.audiowide,
    GoogleFonts.orbitron,
    GoogleFonts.specialElite,
    GoogleFonts.courierPrime,
    GoogleFonts.firaCode,
    GoogleFonts.sourceCodePro,
    GoogleFonts.rockSalt,
    GoogleFonts.sacramento,
    GoogleFonts.tangerine,
    GoogleFonts.greatVibes,
    GoogleFonts.ultra,
    GoogleFonts.shrikhand,
    GoogleFonts.bungee,
    GoogleFonts.bungeeShade,
    GoogleFonts.bungeeInline,
    GoogleFonts.cabinSketch,
    GoogleFonts.frederickaTheGreat,
    GoogleFonts.fingerPaint,
    GoogleFonts.rye,
    GoogleFonts.sancreek,
    GoogleFonts.unifrakturMaguntia,
    GoogleFonts.blackOpsOne,
    GoogleFonts.wallpoet,
    GoogleFonts.syneMono,
    GoogleFonts.dmSerifDisplay,
    GoogleFonts.majorMonoDisplay,
    GoogleFonts.sixCaps,
    GoogleFonts.aboreto,
    GoogleFonts.silkscreen,
    GoogleFonts.rubikGlitch,
    GoogleFonts.rubikIso,
    GoogleFonts.rubikMicrobe,
    GoogleFonts.rubikWetPaint,
    GoogleFonts.fasterOne,
    GoogleFonts.frijole,
    GoogleFonts.nosifer,
    GoogleFonts.zcoolKuaiLe,
    GoogleFonts.zcoolQingKeHuangYou,
  ];

  // Subset of fonts specifically chosen for "Active Inference" - irregular, dysfluent, or handwriting
  // to maximize "micro-surprisal".
  late final List<
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
  _dysfluentFonts = [
    GoogleFonts.vt323,
    GoogleFonts.permanentMarker,
    GoogleFonts.shadowsIntoLight,
    GoogleFonts.indieFlower,
    GoogleFonts.amaticSc,
    GoogleFonts.specialElite,
    GoogleFonts.rockSalt,
    GoogleFonts.cabinSketch,
    GoogleFonts.frederickaTheGreat,
    GoogleFonts.fingerPaint,
    GoogleFonts.syneMono,
    GoogleFonts.majorMonoDisplay,
    GoogleFonts.bungeeShade,
    GoogleFonts.wallpoet,
    GoogleFonts.rubikGlitch,
    GoogleFonts.rubikMicrobe,
    GoogleFonts.rubikWetPaint,
    GoogleFonts.frijole,
    GoogleFonts.nosifer,
  ];

  // 3. High-Salience Font Collection Curation
  // Fonts that trigger "Phasic Bursts" due to extreme novelty or weight.
  late final List<
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
  _salientFonts = [
    GoogleFonts.audiowide,
    GoogleFonts.orbitron,
    GoogleFonts.bangers,
    GoogleFonts.creepster,
    GoogleFonts.blackOpsOne,
    GoogleFonts.silkscreen,
    GoogleFonts.monoton,
    GoogleFonts.righteous,
    GoogleFonts.ultra,
    GoogleFonts.fasterOne,
    GoogleFonts.bungeeInline,
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

  // 4. Color Generation Logic (Neon/Cyberpunk)
  Color generateStimulatingColor() {
    // High-saturation, high-brightness colors for maximum visual impact in DB modes
    List<Color> palette = [
      Colors.cyanAccent, // Cyberpunk Cyan
      Colors.limeAccent, // Biohazard Lime
      Colors.pinkAccent, // Neon Pink
      Colors.amberAccent, // Warning Amber
      Colors.lightBlueAccent, // Electric Blue
      Colors.tealAccent, // Matrix Teal
      Colors.purpleAccent, // Vaporwave Purple
      Colors.deepOrangeAccent, // Lava Orange
      Colors.redAccent, // Alert Red
      Colors.white, // Pure White (Contract)
      Colors.yellowAccent, // Hazard Yellow
      const Color(0xFF00FF00), // Pure Terminal Green
      const Color(0xFFFF00FF), // Magenta
    ];
    return palette[_random.nextInt(palette.length)];
  }

  // Helper for generating background tints for Structure Chaos
  Color generateChaosBackgroundColor() {
    return generateStimulatingColor().withOpacity(
      0.1 + _random.nextDouble() * 0.2,
    );
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

  // 5. Active Inference Style Generator
  /// Generates a specific style for "Active Inference" focused reading.
  /// Prioritizes dysfluency and irregularity to prevent habituation.
  TextStyle generateActiveInferenceStyle({
    double baseSize = 20.0,
    double chaosInternal = 1.0,
  }) {
    // 70% chance to use a specifically dysfluent font, 30% chance for random font
    var fontGetter = _random.nextDouble() < 0.7
        ? _dysfluentFonts[_random.nextInt(_dysfluentFonts.length)]
        : _fonts[_random.nextInt(_fonts.length)];

    // Variation in size to create "visual noise"
    double size = baseSize + (_random.nextDouble() * 8 - 4) * chaosInternal;
    if (size < 14) size = 14;

    // High contrast colors, but occasionally slight dimming to force focus
    Color fgColor = generateStimulatingColor();

    // 8. Letter Spacing/Tracking Modulation
    // Irregular spacing forces slower, more deliberate saccades
    double letterSpacing = generateChaoticSpacing(chaosInternal);

    // 9. Word Spacing & Line Height Modulation parameters (applied to widget usually, but can be simulated here via visual space)
    double wordSpacing = (_random.nextDouble() * 4) * chaosInternal;

    return fontGetter(
      fontSize: size,
      fontWeight: _random.nextBool() ? FontWeight.bold : FontWeight.normal,
      color: fgColor,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      // 10. Background/Structure Chaos (Highlights)
      backgroundColor: _random.nextDouble() < (0.05 * chaosInternal)
          ? generateChaosBackgroundColor()
          : null,
      decoration: _random.nextDouble() < (0.02 * chaosInternal)
          ? TextDecoration.underline
          : TextDecoration.none,
      decorationColor: fgColor,
      decorationStyle: TextDecorationStyle.wavy,
    );
  }

  // 7. Rotation/Tilt Logic (Geometric Prior Violation)
  double generateRotation(double chaosFactor) {
    // Returns radians.
    double maxDegrees = 5.0 * chaosFactor;
    double degrees = (_random.nextDouble() * 2 * maxDegrees) - maxDegrees;
    return degrees * (pi / 180.0);
  }

  /// Generates a rotation specifically for Active Inference.
  /// Enforces a minimum tilt to ensure the "strict geometric prior" is violated.
  double generateActiveInferenceRotation() {
    // Minimum tilt ensures the brain CANNOT process this as standard text.
    double minDegrees = 2.0;
    double maxDegrees = 7.0;

    double degrees =
        minDegrees + _random.nextDouble() * (maxDegrees - minDegrees);

    // Randomly flip direction
    if (_random.nextBool()) {
      degrees = -degrees;
    }

    return degrees * (pi / 180.0);
  }

  // 8. Letter Spacing/Tracking Modulation (Helper)
  double generateChaoticSpacing(double chaosFactor) {
    // Standard is 0. Ranges from -2.0 (condensed) to 5.0 (expanded)
    return (_random.nextDouble() * 6 - 2.0) * chaosFactor;
  }

  // 9. Word Spacing & Line Height Modulation (Helpers)
  double generateChaoticLineHeight(double chaosFactor) {
    // Standard is 1.0? usually null.
    // Range 0.8 (crowded) to 1.5 (spacious)
    return 1.0 + (_random.nextDouble() * 0.7 - 0.2) * chaosFactor;
  }

  /// Determines if a specific word should trigger a Phasic Burst (Novelty Trigger).
  /// [probability] determines frequency (0.0 to 1.0).
  /// A probability of 0.05 means ~1 in 20 words.
  bool isPhasicTrigger(double probability) {
    return _random.nextDouble() < probability;
  }

  /// Generates a "High Salience" style for Phasic Bursts.
  /// Used for the "Novelty Trigger" LC-NE stimulation.
  /// Features:
  /// - Distinctive fonts (Orbitron, Bangers, Creepster)
  /// - High Contrast / Neon Colors
  /// - Size variability (usually larger)

  TextStyle generatePhasicStyle({
    double baseSize = 20.0,
    required TextStyle baseStyle,
  }) {
    // Select a font that is visually distinct from standard reading fonts
    var fontGetter = _salientFonts[_random.nextInt(_salientFonts.length)];

    // Neon / High Intensity Colors
    List<Color> neonColors = [
      Colors.cyanAccent,
      Colors.greenAccent,
      Colors.pinkAccent,
      Colors.amberAccent,
      Colors.purpleAccent,
      Colors.yellowAccent,
    ];
    Color color = neonColors[_random.nextInt(neonColors.length)];

    // Increase size for salience (1.3x to 1.8x)
    double size = baseSize * (1.3 + _random.nextDouble() * 0.5);

    return fontGetter(
      textStyle: baseStyle,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.5, // Expanded for emphasis
      shadows: [
        BoxShadow(
          color: color.withOpacity(0.8),
          blurRadius: 12,
          spreadRadius: 4,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.5),
          blurRadius: 2,
          spreadRadius: 0,
        ),
      ],
      // 10. Background/Structure Chaos (Force underline for phasic trigger sometimes)
      decoration: TextDecoration.underline,
      decorationColor: color,
      decorationStyle: TextDecorationStyle.double,
    );
  }
}
