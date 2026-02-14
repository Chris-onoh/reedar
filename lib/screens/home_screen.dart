import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/pdf_service.dart';
import 'reader_screen.dart';
import 'manifesto_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PdfService _pdfService = PdfService();
  bool _isLoading = false;
  String _statusText = "SYSTEM IDLE";

  Future<void> _pickFile() async {
    setState(() {
      _isLoading = true;
      _statusText = "SCANNING FILE SYSTEM...";
    });

    try {
      final file = await _pdfService.pickPdfFile();
      if (file != null) {
        setState(() => _statusText = "DECRYPTING PDF DATA...");
        // Add artificial delay for "processing" vibe
        await Future.delayed(const Duration(milliseconds: 800));

        final text = await _pdfService.extractText(file);

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReaderScreen(content: text),
            ),
          );
        }
      } else {
        setState(() => _statusText = "SELECTION ABORTED");
      }
    } catch (e) {
      setState(() => _statusText = "CRITICAL ERROR: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background grid simulation
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                      "REEDAR",
                      style: GoogleFonts.orbitron(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: Colors.cyanAccent,
                        letterSpacing: 8,
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 2000.ms, color: Colors.purpleAccent)
                    .effect(duration: 3000.ms),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.cyanAccent.withOpacity(0.5),
                    ),
                    color: Colors.black.withOpacity(0.8),
                  ),
                  child: Text(
                    "NEURO-STIMULATION PROTOCOL: ACTIVE",
                    style: GoogleFonts.shareTechMono(
                      color: Colors.cyanAccent,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // Main Action Button
                GestureDetector(
                      onTap: _isLoading ? null : _pickFile,
                      child: Container(
                        height: 80,
                        width: 280,
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? Colors.grey[900]
                              : Colors.cyanAccent.withOpacity(0.1),
                          border: Border.all(
                            color: _isLoading ? Colors.grey : Colors.cyanAccent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyanAccent.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            _isLoading ? "PROCESSING..." : "INITIATE UPLOAD",
                            style: GoogleFonts.audiowide(
                              fontSize: 24,
                              color: _isLoading ? Colors.grey : Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .scale(duration: 200.ms, curve: Curves.easeInOut)
                    .then(delay: 1000.ms)
                    .shake(hz: 4, curve: Curves.easeInOut),

                const SizedBox(height: 20),

                // Manifesto Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManifestoScreen(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.cyanAccent.withOpacity(0.7),
                  ),
                  child: Text(
                    "VIEW PROTOCOL MANIFESTO",
                    style: GoogleFonts.shareTechMono(
                      fontSize: 14,
                      letterSpacing: 2,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  _statusText,
                  style: GoogleFonts.shareTechMono(
                    color: Colors.redAccent,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
