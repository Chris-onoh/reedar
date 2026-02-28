import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'text_processor.dart';

class PdfExtractionRequest {
  final String? path;
  final List<int>? bytes;

  PdfExtractionRequest({this.path, this.bytes});
}

class PdfService {
  // Instance of processor not needed here anymore as we use it inside isolate
  // final TextProcessor _textProcessor = TextProcessor();

  Future<PlatformFile?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true, // Important for web to get bytes
    );

    if (result != null) {
      return result.files.single;
    }
    return null;
  }

  Future<ProcessedPdf> extractText(PlatformFile file) async {
    // Prepare request for isolate
    final request = PdfExtractionRequest(path: file.path, bytes: file.bytes);

    try {
      return await compute(_processPdfInIsolate, request);
    } catch (e) {
      print('Error extracting text in isolate: $e');
      return ProcessedPdf(
        rawText: 'Error analyzing file integrity.',
        chunks: ['Error analyzing file integrity.'],
        metadata: {},
      );
    }
  }

  static Future<ProcessedPdf> _processPdfInIsolate(
    PdfExtractionRequest request,
  ) async {
    final TextProcessor textProcessor = TextProcessor();

    try {
      List<int> bytes;
      if (request.bytes != null) {
        bytes = request.bytes!;
      } else if (request.path != null) {
        bytes = await File(request.path!).readAsBytes();
      } else {
        throw Exception("No data or path available for PDF file");
      }

      final PdfDocument document = PdfDocument(inputBytes: bytes);

      // Extract text - this is the heavy synchronous part
      String rawText = PdfTextExtractor(document).extractText();

      if (rawText.isEmpty) {
        rawText = " [Unreadable or Scanned PDF Content] ";
      }

      document.dispose();

      // Process text - also heavy
      String cleanedText = textProcessor.cleanText(rawText);
      List<String> chunks = textProcessor.chunkText(cleanedText);
      Map<String, dynamic> metadata = textProcessor.extractMetadata(
        cleanedText,
      );

      return ProcessedPdf(
        rawText: cleanedText,
        chunks: chunks,
        metadata: metadata,
      );
    } catch (e) {
      // Re-throw to be caught by main thread
      throw Exception('Failed to process PDF: $e');
    }
  }
}

class ProcessedPdf {
  final String rawText;
  final List<String> chunks;
  final Map<String, dynamic> metadata;

  ProcessedPdf({
    required this.rawText,
    required this.chunks,
    required this.metadata,
  });
}
