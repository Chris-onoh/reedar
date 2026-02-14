import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/chaos_engine.dart';

class ReaderScreen extends StatefulWidget {
  final String content;

  const ReaderScreen({super.key, required this.content});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final ChaosEngine _chaosEngine = ChaosEngine();
  final ScrollController _scrollController = ScrollController();

  // Settings
  double _chaosLevel = 1.0;
  double _baseFontSize = 24.0;

  late List<String> _words;

  @override
  void initState() {
    super.initState();
    // Split by whitespace to get words
    _words = widget.content.split(RegExp(r'\s+'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Content Area
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.black,
                floating: true,
                title: Text(
                  "NEURAL FEED",
                  style: GoogleFonts.orbitron(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.cyanAccent),
                    onPressed: () {
                      _showSettingsDialog();
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: _buildChaoticWords(),
                  ),
                ),
              ),
            ],
          ),

          // Vignette effect
          IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  stops: const [0.7, 1.0],
                  radius: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: () {
          setState(() {
            // Re-render to regenerate chaos
          });
        },
        child: const Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }

  List<Widget> _buildChaoticWords() {
    return _words.map((word) {
      final style = _chaosEngine.generateChaoticStyle(
        baseSize: _baseFontSize,
        chaosFactor: _chaosLevel,
      );

      final rotation = _chaosEngine.generateRotation(_chaosLevel);

      return Transform.rotate(
        angle: rotation,
        child:
            Container(
                  padding: EdgeInsets.all(_chaosLevel * 2),
                  decoration: BoxDecoration(
                    color: style.backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    word,
                    style: style.copyWith(
                      backgroundColor: Colors.transparent,
                    ), // Applied to container instead
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .shimmer(
                  delay: Duration(
                    milliseconds: (DateTime.now().millisecond % 1000) + 1000,
                  ),
                  duration: 1000.ms,
                ),
      );
    }).toList();
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: Border.all(color: Colors.cyanAccent),
        title: Text(
          "CHAOS CONFIGURATION",
          style: GoogleFonts.orbitron(color: Colors.cyanAccent),
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "INTENSITY: ${_chaosLevel.toStringAsFixed(1)}",
                  style: GoogleFonts.shareTechMono(color: Colors.white),
                ),
                Slider(
                  value: _chaosLevel,
                  min: 0.1,
                  max: 3.0,
                  activeColor: Colors.cyanAccent,
                  onChanged: (value) {
                    setDialogState(() => _chaosLevel = value);
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "BASE SIZE: ${_baseFontSize.toStringAsFixed(1)}",
                  style: GoogleFonts.shareTechMono(color: Colors.white),
                ),
                Slider(
                  value: _baseFontSize,
                  min: 12.0,
                  max: 48.0,
                  activeColor: Colors.purpleAccent,
                  onChanged: (value) {
                    setDialogState(() => _baseFontSize = value);
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
