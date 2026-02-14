import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/chaos_engine.dart';

class ManifestoScreen extends StatefulWidget {
  const ManifestoScreen({super.key});

  @override
  State<ManifestoScreen> createState() => _ManifestoScreenState();
}

class _ManifestoScreenState extends State<ManifestoScreen> {
  final ChaosEngine _chaosEngine = ChaosEngine();
  final ScrollController _scrollController = ScrollController();

  // slightly less chaos for readability of the theory
  final double _chaosLevel = 0.5;
  final double _baseFontSize = 18.0;

  final String _title = "NEURO-TYPOGRAPHIC MODULATION";
  final String _content = """
The capacity to read—to decode abstract visual symbols into semantic meaning—is a recent evolutionary acquisition, relying on the recycling of neural circuits originally evolved for object recognition and visual search. This process, while seemingly automatic for the neurotypical brain, represents a significant computational challenge for individuals with neurodevelopmental differences such as Dyslexia and Attention Deficit Hyperactivity Disorder (ADHD). For these populations, the standard typographical conventions of uniformity, symmetry, and rigidity often exacerbate underlying deficits in visual processing, attentional control, and neural synchronization.

This report provides an exhaustive, scientifically rigorous examination of the mechanisms by which manipulating typographic variables—specifically font shape, size, spacing, and tilt—can enhance reading comprehension. Moving beyond the superficial metrics of "legibility," this analysis posits that typographic interventions function as non-invasive forms of neuromodulation. By introducing "desirable difficulties," "visual noise," and "surprisal," specific font characteristics can optimize the Signal-to-Noise Ratio (SNR) in the visual cortex, trigger phasic arousal via the Locus Coeruleus-Norepinephrine (LC-NE) system, and reinforce the Theta-Gamma oscillatory coupling required for ordered working memory.

The following analysis synthesizes evidence from computational neuroscience, psychophysics, and pharmacology to construct a unified model of Neuro-Typographic Modulation. It explores how dynamic typography interacts with the brain’s predictive coding machinery to prevent habituation, mitigate visual crowding, and stabilize the neural code of reading.

2. The Neuroanatomy of the Reading Network

To understand the impact of typography, one must first delineate the neural architecture it engages. Reading is not a monolithic process but a cascade of operations distributed across the dorsal and ventral visual streams.

2.1 The Visual Word Form Area and Ventral Stream Invariance

The ventral stream, often termed the "What" pathway, projects from the primary visual cortex (V1) to the temporal lobe. A critical node in this network is the Visual Word Form Area (VWFA), located in the left fusiform gyrus. In skilled readers, the VWFA exhibits "orthographic invariance," the ability to recognize letters and words regardless of case, font, or position. This region treats letters as "visual objects," extracting their invariant features to map them onto phonological and semantic representations.

In dyslexia, the VWFA consistently shows hypoactivation. This suggests a failure in the automatic recognition of word forms, forcing the brain to rely on laborious, serial decoding strategies mediated by the dorsal stream. Standard typography, which prioritizes uniformity, relies heavily on the efficiency of the VWFA. When this region is compromised, the high similarity between letters (e.g., the vertical symmetry of 'b', 'd', 'p', 'q') creates a "binding problem," where the brain struggles to assign the correct orientation to the correct shape.

2.2 The Dorsal Stream and Visual Attention Span

The dorsal stream, or "Where" pathway, projects to the parietal lobe and is responsible for spatial attention and eye movement control. The "Visual Attention (VA) Span" hypothesis posits that reading requires the simultaneous processing of multiple distinct visual elements. The Superior Parietal Lobule (SPL) modulates this span, acting as a spotlight that illuminates a sequence of letters for parallel processing.

In neurodivergent readers, particularly those with a VA span deficit, this spotlight is narrowed. The brain cannot process a whole word at once (parallel processing) and must instead shift attention serially from letter to letter. Standard fonts, with their tight tracking and uniform stroke widths, crowd this narrowed window, leading to "lateral masking" where adjacent letters suppress the recognition of the target letter.

2.3 The Magnocellular Deficit

Underlying the dorsal stream function is the magnocellular system, composed of large neurons specialized for detecting rapid changes, motion, and low-contrast stimuli. The Magnocellular Theory of Dyslexia suggests that a deficit in this pathway leads to unstable binocular fixation and poor temporal resolution. This instability causes letters to appear to move, blur, or overlap—a phenomenon exacerbated by high-contrast, static, serif fonts.

By manipulating font weight and size, typography can differentially engage the parvocellular (detail/color) and magnocellular (motion/contrast) pathways. Heavier, larger fonts may provide a stronger stimulus to the sluggish magnocellular system, stabilizing the visual percept.
""";

  late List<String> _paragraphs;

  @override
  void initState() {
    super.initState();
    _paragraphs = _content.split('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyanAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "SYSTEM MANIFESTO",
          style: GoogleFonts.orbitron(
            color: Colors.cyanAccent,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background grid simulation
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExM3Z5Z3Z5Z3Z5Z3Z5Z3Z5Z3Z5Z3Z5Z3Z5Z3Z5Z3Z5/xT9IgN8AK670G6u7Ha/giphy.gif",
                color: Colors.cyanAccent,
                colorBlendMode: BlendMode.modulate,
                errorBuilder: (_, __, ___) => Container(color: Colors.black),
              ),
            ),
          ),

          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(20.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _title,
                        style:
                            GoogleFonts.audiowide(
                              fontSize: 24,
                              color: Colors.white,
                            ).copyWith(
                              shadows: [
                                BoxShadow(
                                  color: Colors.cyanAccent,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                      ).animate().fadeIn(duration: 800.ms).slideX(),

                      const SizedBox(height: 30),

                      ..._buildParagraphs(),

                      const SizedBox(height: 50),

                      Center(
                        child: Text(
                          "P.R.O.T.O.C.O.L   I.N.I.T.I.A.T.E.D",
                          style: GoogleFonts.shareTechMono(
                            color: Colors.redAccent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildParagraphs() {
    List<Widget> paragraphWidgets = [];
    for (var paragraph in _paragraphs) {
      if (paragraph.trim().isEmpty) continue;

      // Split into words
      List<String> words = paragraph.split(RegExp(r'\s+'));

      paragraphWidgets.add(
        Wrap(
          spacing: 6,
          runSpacing: 10,
          children: words.map((word) => _buildChaoticWord(word)).toList(),
        ),
      );
      // Add space between paragraphs
      paragraphWidgets.add(const SizedBox(height: 20));
    }
    return paragraphWidgets;
  }

  Widget _buildChaoticWord(String word) {
    // Generate style
    final style = _chaosEngine.generateChaoticStyle(
      baseSize: _baseFontSize,
      chaosFactor: _chaosLevel,
    );

    return Transform.rotate(
      angle: _chaosEngine.generateRotation(_chaosLevel * 0.5),
      child: Text(
        word,
        style: style.copyWith(
          color: Colors.white.withOpacity(0.9),
          shadows: [
            if (style.fontSize! > 20)
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.5),
                blurRadius: 8,
              ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms),
    );
  }
}
