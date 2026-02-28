import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/chaos_engine.dart';

/// Data Transfer Object for a single word's styling
class ChaosWordData {
  final String word;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final int colorValue; // Store as int for easy passing
  final int? backgroundColorValue;
  final double letterSpacing;
  final double wordSpacing;
  final double rotation;
  final TextDecoration decoration;
  final int decorationColorValue;
  final TextDecorationStyle decorationStyle;

  ChaosWordData({
    required this.word,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
    required this.colorValue,
    this.backgroundColorValue,
    required this.letterSpacing,
    required this.wordSpacing,
    required this.rotation,
    this.decoration = TextDecoration.none,
    required this.decorationColorValue,
    this.decorationStyle = TextDecorationStyle.solid,
  });
}

/// Request object for the isolate
class ChaosProcessingRequest {
  final String text;
  final double chaosLevel;
  final bool activeInferenceMode;
  final double baseFontSize;

  ChaosProcessingRequest({
    required this.text,
    required this.chaosLevel,
    required this.activeInferenceMode,
    required this.baseFontSize,
  });
}

class ChaosService {
  Future<List<List<ChaosWordData>>> processTextInBackground(
    String text, {
    double chaosLevel = 1.0,
    bool activeInferenceMode = false,
    double baseFontSize = 22.0,
  }) async {
    final request = ChaosProcessingRequest(
      text: text,
      chaosLevel: chaosLevel,
      activeInferenceMode: activeInferenceMode,
      baseFontSize: baseFontSize,
    );

    return await compute(_processText, request);
  }

  /// This function runs in the isolate
  static List<List<ChaosWordData>> _processText(
    ChaosProcessingRequest request,
  ) {
    final ChaosEngine engine = ChaosEngine();
    final List<String> words = request.text.split(RegExp(r'\s+'));
    final List<ChaosWordData> allWordsData = [];

    for (String word in words) {
      if (word.isEmpty) continue;

      if (request.activeInferenceMode) {
        // Generate Active Inference Style
        final style = engine.generateActiveInferenceStyle(
          baseSize: request.baseFontSize,
          chaosInternal: request.chaosLevel,
        );
        final rotation = engine.generateActiveInferenceRotation();

        allWordsData.add(
          ChaosWordData(
            word: word,
            fontFamily: style.fontFamily ?? '',
            fontSize: style.fontSize ?? request.baseFontSize,
            fontWeight: style.fontWeight ?? FontWeight.normal,
            fontStyle: style.fontStyle ?? FontStyle.normal,
            colorValue: style.color?.value ?? 0xFF000000,
            backgroundColorValue: style.backgroundColor?.value,
            letterSpacing: style.letterSpacing ?? 0.0,
            wordSpacing: style.wordSpacing ?? 0.0,
            rotation: rotation,
            decoration: style.decoration ?? TextDecoration.none,
            decorationColorValue: style.decorationColor?.value ?? 0xFF000000,
            decorationStyle: style.decorationStyle ?? TextDecorationStyle.solid,
          ),
        );
      } else {
        // Generate Standard Chaotic Style
        final style = engine.generateChaoticStyle(
          baseSize: request.baseFontSize,
          chaosFactor: request.chaosLevel,
        );
        final rotation = engine.generateRotation(request.chaosLevel);

        allWordsData.add(
          ChaosWordData(
            word: word,
            fontFamily: style.fontFamily ?? '',
            fontSize: style.fontSize ?? request.baseFontSize,
            fontWeight: style.fontWeight ?? FontWeight.normal,
            fontStyle: style.fontStyle ?? FontStyle.normal,
            colorValue: style.color?.value ?? 0xFF000000,
            backgroundColorValue: style.backgroundColor?.value,
            letterSpacing: style.letterSpacing ?? 0.0,
            wordSpacing: style.wordSpacing ?? 0.0,
            rotation: rotation,
            decoration: style.decoration ?? TextDecoration.none,
            decorationColorValue: style.decorationColor?.value ?? 0xFF000000,
            decorationStyle: style.decorationStyle ?? TextDecorationStyle.solid,
          ),
        );
      }
    }

    // Chunk the data for easier rendering list logic (e.g., 50 words per chunk)
    return _chunkList(allWordsData, 50);
  }

  static List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (int i = 0; i < list.length; i += chunkSize) {
      chunks.add(
        list.sublist(
          i,
          i + chunkSize > list.length ? list.length : i + chunkSize,
        ),
      );
    }
    return chunks;
  }
}
