import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CalibrationScreen extends StatefulWidget {
  const CalibrationScreen({super.key});

  @override
  State<CalibrationScreen> createState() => _CalibrationScreenState();
}

class _CalibrationScreenState extends State<CalibrationScreen> {
  String _statusData = "INITIALIZING CORE...";
  double _progress = 0.0;
  final List<String> _calibrationSteps = [
    "MEASURING SACCADIC LATENCY...",
    "ANALYZING PUPILLARY RESPONSE...",
    "SYNCING THETA WAVES...",
    "OPTIMIZING VISUAL CORTEX SNR...",
    "ESTABLISHING BASELINE CHAOS...",
    "CALIBRATION COMPLETE.",
  ];

  @override
  void initState() {
    super.initState();
    _runCalibration();
  }

  void _runCalibration() async {
    for (int i = 0; i < _calibrationSteps.length; i++) {
      await Future.delayed(
        Duration(milliseconds: 800 + Random().nextInt(1000)),
      );
      if (!mounted) return;

      setState(() {
        _statusData = _calibrationSteps[i];
        _progress = (i + 1) / _calibrationSteps.length;
      });
    }

    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      Navigator.pop(context, {
        'chaosLevel': 1.2,
        'baseSize': 18.0,
      }); // Return calibrated values
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Cyberpunk Grid Background
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Scanner Eye / Visual
                Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.cyanAccent, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.cyanAccent.withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Center(
                        child:
                            Icon(
                                  Icons.remove_red_eye,
                                  size: 80,
                                  color: Colors.cyanAccent,
                                )
                                .animate(onPlay: (c) => c.repeat())
                                .shimmer(
                                  duration: 1200.ms,
                                  color: Colors.purpleAccent,
                                ),
                      ),
                    )
                    .animate()
                    .scale(duration: 500.ms)
                    .then(delay: 500.ms)
                    .shake(hz: 2),

                const SizedBox(height: 50),

                Text(
                  "NEURAL CALIBRATION",
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),

                const SizedBox(height: 30),

                // Status Text
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  color: Colors.black.withOpacity(0.8),
                  child: Text(
                    _statusData,
                    style: GoogleFonts.shareTechMono(
                      color: Colors.greenAccent,
                      fontSize: 16,
                    ),
                  ).animate().fadeIn(),
                ),

                const SizedBox(height: 30),

                // Progress Bar
                Container(
                  width: 300,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        boxShadow: [
                          BoxShadow(color: Colors.cyanAccent, blurRadius: 10),
                        ],
                      ),
                    ),
                  ).animate().slideX(duration: 200.ms),
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
      ..color = Colors.green.withOpacity(0.05)
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
