import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/chaos_engine.dart';
import '../services/pdf_service.dart';
import '../widgets/neural_sync_indicator.dart';

class ReaderScreen extends StatefulWidget {
  final ProcessedPdf processedPdf;

  const ReaderScreen({super.key, required this.processedPdf});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final ChaosEngine _chaosEngine = ChaosEngine();
  final ScrollController _scrollController = ScrollController();

  // Settings
  double _chaosLevel = 1.0;
  double _baseFontSize = 24.0;
  bool _activeInferenceMode = false;
  bool _lcNeMode = false;
  bool _autoScroll = false;
  double _scrollSpeed = 50.0; // Pixels per second

  Timer? _scrollTimer;
  List<String> _displayWords = [];

  // Progress
  // int _currentWordIndex = 0; // Reserved for future analytics

  @override
  void initState() {
    super.initState();
    // Flatten chunks into a single word list for now to maintain the "Stream"
    // In strict mode we might use chunks, but for chaos stream, words are better.
    _displayWords = widget.processedPdf.rawText.split(RegExp(r'\s+'));
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleAutoScroll() {
    setState(() {
      _autoScroll = !_autoScroll;
    });

    if (_autoScroll) {
      _startAutoScroll();
    } else {
      _scrollTimer?.cancel();
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_scrollController.hasClients) return;

      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;

      if (currentScroll >= maxScroll) {
        timer.cancel();
        setState(() => _autoScroll = false);
      } else {
        _scrollController.jumpTo(currentScroll + (_scrollSpeed / 20));
      }
    });
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
                backgroundColor: Colors.black.withOpacity(0.9),
                floating: true,
                pinned: true,
                title: Row(
                  children: [
                    Text(
                      "NEURAL FEED",
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const NeuralSyncIndicator(synced: true),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _autoScroll
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: _autoScroll ? Colors.greenAccent : Colors.white,
                    ),
                    onPressed: _toggleAutoScroll,
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.cyanAccent),
                    onPressed: () {
                      _showSettingsDialog();
                    },
                  ),
                ],
              ),

              // Progress Bar (Saccadic Position)
              SliverToBoxAdapter(
                child: LinearProgressIndicator(
                  value:
                      _scrollController.hasClients &&
                          _scrollController.position.maxScrollExtent > 0
                      ? _scrollController.offset /
                            _scrollController.position.maxScrollExtent
                      : 0,
                  backgroundColor: Colors.grey[900],
                  color: Colors.purpleAccent.withOpacity(0.5),
                  minHeight: 2,
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: _buildChaoticWords(),
                  ),
                ),
              ),

              // Bottom padding for scrolling
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
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

          // Overlay Stats (optional, hidden by default or toggleable)
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
    // We limit rendering to visible area in a real app, but for now wrap everything.
    // Optimization: In a real "infinite" reader, we'd use ListView.builder,
    // but Wrap gives the best "chaotic cloud" feel. To prevent lag on large PDFs,
    // we might need to paginate. For now, we assume reasonable chapter size.

    return _displayWords.asMap().entries.map((entry) {
      int index = entry.key;
      String word = entry.value;

      // 16. "Surprisal" Probability Calculator (Mock integration)
      // In real implementation we'd use widget.processedPdf.metadata or per-word scores
      bool isPhasic = _lcNeMode && _chaosEngine.isPhasicTrigger(0.05);

      if (isPhasic) {
        final style = _chaosEngine.generatePhasicStyle(
          baseSize: _baseFontSize,
          baseStyle: GoogleFonts.roboto(),
        );

        // Phasic items also get a shake or pulse + Haptic
        // Trigger visual feedback.

        return Text(word, style: style)
            .animate()
            .scale(duration: 300.ms, curve: Curves.easeInOut)
            .shake(duration: 500.ms, hz: 4);
      }

      if (_activeInferenceMode) {
        final style = _chaosEngine.generateActiveInferenceStyle(
          baseSize: _baseFontSize,
          chaosInternal: _chaosLevel,
        );
        final rotation = _chaosEngine.generateActiveInferenceRotation();

        return Transform.rotate(
          angle: rotation,
          child: Container(
            padding: EdgeInsets.all(4.0),
            decoration: BoxDecoration(color: style.backgroundColor),
            child: Text(
              word,
              style: style.copyWith(backgroundColor: Colors.transparent),
            ),
          ).animate().fadeIn(duration: 400.ms),
        );
      } else {
        final style = _chaosEngine.generateChaoticStyle(
          baseSize: _baseFontSize,
          chaosFactor: _chaosLevel,
        );

        final rotation = _chaosEngine.generateRotation(_chaosLevel);

        // 24. "Saccadic" Navigation - tap to focus
        return GestureDetector(
          onTap: () {
            // Highlight word logic or text-to-speech trigger
            setState(() {
              // Focus interaction
            });
          },
          child: Transform.rotate(
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
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .shimmer(
                      delay: Duration(milliseconds: (index % 10) * 100 + 1000),
                      duration: 1000.ms,
                    ),
          ),
        );
      }
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
            return SingleChildScrollView(
              child: Column(
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
                  const SizedBox(height: 20),
                  Text(
                    "AUTO-SCROLL SPEED",
                    style: GoogleFonts.shareTechMono(color: Colors.white),
                  ),
                  Slider(
                    value: _scrollSpeed,
                    min: 10.0,
                    max: 200.0,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setDialogState(() => _scrollSpeed = value);
                      if (_autoScroll) _startAutoScroll();
                    },
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: Text(
                      "ACTIVE INFERENCE",
                      style: GoogleFonts.shareTechMono(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Maximize prediction error",
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: _activeInferenceMode,
                    activeColor: Colors.redAccent,
                    onChanged: (val) {
                      setDialogState(() => _activeInferenceMode = val);
                      setState(() {});
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      "LC-NE PHASIC",
                      style: GoogleFonts.shareTechMono(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Novelty Triggers",
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: _lcNeMode,
                    activeColor: Colors.greenAccent,
                    onChanged: (val) {
                      setDialogState(() => _lcNeMode = val);
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
