import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'text_processor.dart';

class PdfService {
  final TextProcessor _textProcessor = TextProcessor();

  Future<File?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<ProcessedPdf> extractText(File file) async {
    try {
      final List<int> bytes = await file.readAsBytes();
      final PdfDocument document = PdfDocument(inputBytes: bytes);
      String rawText = PdfTextExtractor(document).extractText();
      document.dispose();

      // Process result
      String cleanedText = _textProcessor.cleanText(rawText);
      List<String> chunks = _textProcessor.chunkText(cleanedText);
      Map<String, dynamic> metadata = _textProcessor.extractMetadata(
        cleanedText,
      );

      return ProcessedPdf(
        rawText: cleanedText,
        chunks: chunks,
        metadata: metadata,
      );
    } catch (e) {
      print('Error extracting text: $e');
      return ProcessedPdf(
        rawText: 'Error analyzing file integrity.',
        chunks: ['Error analyzing file integrity.'],
        metadata: {},
      );
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
