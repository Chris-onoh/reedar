import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/chaos_service.dart';

class ChaosChunkWidget extends StatelessWidget {
  final List<ChaosWordData> chunkData;

  const ChaosChunkWidget({super.key, required this.chunkData});

  @override
  Widget build(BuildContext context) {
    // RepaintBoundary ensures that this chunk is not repainted
    // when other parts of the screen update (like the progress bar).
    return RepaintBoundary(
      child: Wrap(
        spacing: 12, // Increased from 6
        runSpacing: 20, // Increased from 10
        crossAxisAlignment: WrapCrossAlignment.center,
        children: chunkData.map((data) => _buildWord(data)).toList(),
      ),
    );
  }

  Widget _buildWord(ChaosWordData data) {
    // Reconstruct TextStyle from primitive data
    // Note: GoogleFonts.getFont might be expensive if called repeatedly for new fonts.
    // However, since we are likely cycling through a loaded set, it should be okay.
    // If performance is still an issue, we can cache these TextStyles.

    TextStyle style;
    try {
      style = GoogleFonts.getFont(
        data.fontFamily,
        fontSize: data.fontSize,
        fontWeight: data.fontWeight,
        fontStyle: data.fontStyle,
        color: Color(data.colorValue),
        backgroundColor: data.backgroundColorValue != null
            ? Color(data.backgroundColorValue!)
            : null,
        letterSpacing: data.letterSpacing,
        wordSpacing: data.wordSpacing,
        decoration: data.decoration,
        decorationColor: Color(data.decorationColorValue),
        decorationStyle: data.decorationStyle,
      );
    } catch (e) {
      // Fallback if font family string is not recognized by GoogleFonts
      // This can happen if the font name returned by the style object
      // doesn't exactly match the key GoogleFonts expects, or if we need a mapping.
      // For now, let's fallback to a safe font.
      style = TextStyle(
        fontFamily: data.fontFamily, // Try native resolution
        fontSize: data.fontSize,
        fontWeight: data.fontWeight,
        fontStyle: data.fontStyle,
        color: Color(data.colorValue),
        backgroundColor: data.backgroundColorValue != null
            ? Color(data.backgroundColorValue!)
            : null,
        letterSpacing: data.letterSpacing,
        wordSpacing: data.wordSpacing,
        decoration: data.decoration,
        decorationColor: Color(data.decorationColorValue),
        decorationStyle: data.decorationStyle,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
      ), // Force horizontal separation
      child: Transform.rotate(
        angle: data.rotation,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 2,
          ), // Inner padding
          decoration: BoxDecoration(
            color: data.backgroundColorValue != null
                ? Color(data.backgroundColorValue!)
                : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            data.word,
            style: style.copyWith(backgroundColor: Colors.transparent),
          ),
        ),
      ).animate().fadeIn(duration: 400.ms),
    );
  }
}
