import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/pdf_service.dart';
import '../services/chaos_service.dart'; // [NEW]
import '../screens/widgets/chaos_chunk_widget.dart'; // [NEW]
import '../theme/app_theme.dart';

class ReaderScreen extends StatefulWidget {
  final ProcessedPdf processedPdf;

  const ReaderScreen({super.key, required this.processedPdf});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  final ChaosService _chaosService = ChaosService(); // [NEW]
  final ScrollController _scrollController = ScrollController();

  // Settings
  double _chaosLevel = 1.0;
  double _baseFontSize = 22.0;
  bool _activeInferenceMode = false;
  bool _autoScroll = false;
  double _scrollSpeed = 30.0;

  Timer? _scrollTimer;

  // [NEW] Data State
  List<List<ChaosWordData>> _chunkedData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initial processing
    _processText();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // [NEW] Async processing
  Future<void> _processText() async {
    setState(() => _isLoading = true);

    // Offload to isolate
    try {
      final chunks = await _chaosService.processTextInBackground(
        widget.processedPdf.rawText,
        chaosLevel: _chaosLevel,
        activeInferenceMode: _activeInferenceMode,
        baseFontSize: _baseFontSize,
      );

      if (mounted) {
        setState(() {
          _chunkedData = chunks;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error processing text: $e")));
      }
    }
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
      backgroundColor: ReedarColors.cream,
      body: Stack(
        children: [
          // Subtle Background
          Positioned.fill(child: Container(color: ReedarColors.cream)),

          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: ReedarColors.cream.withOpacity(0.95),
                elevation: 0,
                floating: true,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  color: ReedarColors.mocha,
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  "Reading",
                  style: GoogleFonts.outfit(
                    color: ReedarColors.mocha,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _autoScroll
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      color: _autoScroll
                          ? ReedarColors.forest
                          : ReedarColors.mocha,
                    ),
                    onPressed: _toggleAutoScroll,
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: ReedarColors.mocha),
                    onPressed: _showSettingsDialog,
                  ),
                ],
              ),

              // Progress Line
              SliverToBoxAdapter(
                child: StreamBuilder(
                  stream: Stream.periodic(const Duration(milliseconds: 100)),
                  builder: (context, snapshot) {
                    double progress = 0;
                    if (_scrollController.hasClients &&
                        _scrollController.position.maxScrollExtent > 0) {
                      progress =
                          _scrollController.offset /
                          _scrollController.position.maxScrollExtent;
                    }
                    return LinearProgressIndicator(
                      value: progress,
                      backgroundColor: ReedarColors.latte.withOpacity(0.3),
                      color: ReedarColors.matcha,
                      minHeight: 2,
                    );
                  },
                ),
              ),

              // [NEW] Optimized List View
              if (_isLoading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ReedarColors.forest,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ChaosChunkWidget(chunkData: _chunkedData[index]),
                      );
                    }, childCount: _chunkedData.length),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: ReedarColors.matcha,
        foregroundColor: ReedarColors.mocha,
        onPressed: () {
          _processText(); // Trigger re-process
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ReedarColors.cream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          "Reading Settings",
          style: GoogleFonts.outfit(
            color: ReedarColors.mocha,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSlider("Chaos Intensity", _chaosLevel, 0.1, 3.0, (val) {
                    // Update local state for slider UI
                    setDialogState(() => _chaosLevel = val);
                    // Update parent state but don't re-process yet (too heavy)
                    // We will re-process on "Done" or maybe debounce it.
                    // For now, let's update local var.
                  }),
                  const SizedBox(height: 20),
                  _buildSlider("Font Size", _baseFontSize, 14.0, 42.0, (val) {
                    setDialogState(() => _baseFontSize = val);
                  }),
                  const SizedBox(height: 20),
                  _buildSlider("Scroll Speed", _scrollSpeed, 10.0, 150.0, (
                    val,
                  ) {
                    setDialogState(() => _scrollSpeed = val);
                    // Update parent for live scroll speed change
                    setState(() => _scrollSpeed = val);
                    if (_autoScroll) _startAutoScroll();
                  }),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: Text(
                      "Active Inference Mode",
                      style: GoogleFonts.outfit(
                        color: ReedarColors.mocha,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "Maximizes variability",
                      style: GoogleFonts.outfit(
                        color: ReedarColors.charcoal.withOpacity(0.6),
                      ),
                    ),
                    value: _activeInferenceMode,
                    activeColor: ReedarColors.forest,
                    onChanged: (val) {
                      setDialogState(() => _activeInferenceMode = val);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Apply changes on close
              setState(() {
                // Variables were updated in the dialog builder's scope closures
                // but we need to ensure they match before processing
                // Since I used closures capture, they should be updated.
                // Let's trigger re-process.
                _processText();
              });
            },
            child: Text(
              "Done",
              style: GoogleFonts.outfit(color: ReedarColors.mocha),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(color: ReedarColors.charcoal),
            ),
            Text(
              value.toStringAsFixed(1),
              style: GoogleFonts.outfit(
                color: ReedarColors.charcoal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: ReedarColors.matcha,
          inactiveColor: ReedarColors.latte,
          thumbColor: ReedarColors.mocha,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
