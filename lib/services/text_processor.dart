import 'dart:math';

class TextProcessor {
  // Regex for cleaning and tokenization
  final RegExp _whitespaceRegex = RegExp(r'\s+');
  final RegExp _punctuationRegex = RegExp(r'[^\w\s]');
  final RegExp _sentenceSplitRegex = RegExp(r'(?<=[.!?])\s+');

  /// Cleans and normalizes raw text from PDF.
  String cleanText(String rawText) {
    // Remove hyphens at end of lines (de-hyphenation)
    String text = rawText.replaceAll(RegExp(r'-\n'), '');

    // Ensure all types of newlines are treated as spaces first (unless paragraph)
    text = text.replaceAll(RegExp(r'\r\n'), '\n');
    text = text.replaceAll(RegExp(r'\r'), '\n');

    // Replace multiple newlines with a marker
    text = text.replaceAll(RegExp(r'\n\n+'), '||PARAGRAPH||');

    // Split CamelCase words or sticky capitalization (e.g. "end.The" -> "end. The")
    // 1. Lowercase followed by Uppercase (e.g. "wordWord" -> "word Word")
    text = text.replaceAllMapped(RegExp(r'(?<=[a-z])(?=[A-Z])'), (m) => ' ');
    // 2. Period/Comma followed immediately by Upper/Word (e.g. "end.The" -> "end. The")
    text = text.replaceAllMapped(
      RegExp(r'(?<=[.,;:])(?=[A-Za-z])'),
      (m) => ' ',
    );

    // Replace single newlines with spaces
    text = text.replaceAll('\n', ' ');

    // Restore paragraphs
    text = text.replaceAll('||PARAGRAPH||', '\n\n');

    // Collapse multiple spaces
    text = text.replaceAll(_whitespaceRegex, ' ');

    return text.trim();
  }

  /// Splits text into "chunks" (logic/sentence units) for pacing.
  List<String> chunkText(String text) {
    // Split by sentence endings first
    List<String> sentences = text.split(_sentenceSplitRegex);
    List<String> chunks = [];

    for (var sentence in sentences) {
      if (sentence.length > 100) {
        // Sub-split long sentences by flowing punctuation
        var subParts = sentence.split(RegExp(r'[,;:]\s+'));
        chunks.addAll(subParts);
      } else {
        chunks.add(sentence);
      }
    }
    return chunks.where((c) => c.trim().isNotEmpty).toList();
  }

  /// Tokenizes text into words, preserving some punctuation as separate tokens if needed.
  List<String> tokenizeWords(String text) {
    return text.split(' ');
  }

  /// Calculates a "surprisal" score (0.0 to 1.0) for each word.
  /// Higher score = more likely to trigger Phasic Burst.
  Map<int, double> calculateSurprisal(List<String> words) {
    Map<int, double> scores = {};

    // Simple frequency approximation (length + rarity heuristic)
    // In a real system, we'd use a frequency dict.
    // Here: Longer words = higher surprisal.
    // Capitalized words (proper nouns) = higher surprisal.

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      double score = 0.0;

      String cleanWord = word.replaceAll(_punctuationRegex, '');

      // Heuristic 1: Length
      if (cleanWord.length > 7) score += 0.3;
      if (cleanWord.length > 12) score += 0.3;

      // Heuristic 2: Capitalization (likely proper noun if not start of sentence)
      if (word.isNotEmpty &&
          word[0] == word[0].toUpperCase() &&
          i > 0 &&
          !words[i - 1].endsWith('.')) {
        score += 0.3;
      }

      // Heuristic 3: Rare punctuation
      if (word.contains('!') || word.contains('?')) {
        score += 0.2;
      }

      scores[i] = min(score, 1.0);
    }

    return scores;
  }

  /// Extracts "Metadata" - stats for the session.
  Map<String, dynamic> extractMetadata(String text) {
    List<String> words = tokenizeWords(text);
    return {
      'wordCount': words.length,
      'charCount': text.length,
      'estimatedReadingTimeMinutes': (words.length / 200).ceil(), // 200 wpm
      'complexityScore': _calculateComplexity(words),
    };
  }

  double _calculateComplexity(List<String> words) {
    if (words.isEmpty) return 0.0;
    int longWords = words.where((w) => w.length > 6).length;
    return longWords / words.length;
  }
}
