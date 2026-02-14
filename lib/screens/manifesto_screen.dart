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

3. Computational Neuroscience: Predictive Coding and Active Inference

The brain functions as a prediction engine, continuously generating internal models of the world to minimize "surprisal" or prediction error. This framework, known as Predictive Coding or the Free Energy Principle (FEP), offers a compelling explanation for why "irregular" or "tilted" fonts improve attention in ADHD.

3.1 The Free Energy Principle in Reading

According to the FEP, the brain strives to minimize the difference between top-down predictions (priors) and bottom-up sensory inputs (likelihoods).

    Top-Down Priors: In reading, the brain predicts the next word based on syntax and semantics, and the next letter shape based on learned orthographic rules.

    Bottom-Up Inputs: The actual visual data arriving at the retina.

    Prediction Error: The discrepancy between the prediction and the input.

In a standard, highly legible font (e.g., Arial or Times New Roman), the visual priors are extremely strong. The brain's model of the letter 'e' perfectly matches the incoming visual data. The prediction error is minimized almost instantly. While this is efficient for a neurotypical brain, it creates a specific vulnerability for the ADHD brain: Habituation.

3.2 Habituation and the "Glazing Over" Effect

When prediction errors are consistently low, the brain reduces the "precision weighting" (synaptic gain) assigned to the sensory channel. Essentially, the system determines that the visual input offers no new information (no surprisal), and attentional resources are withdrawn. This leads to the phenomenon of "glazing over," where the eyes track the text, but the mind wanders—a hallmark of ADHD reading performance.

3.3 Typographic "Surprisal" and Active Inference

Altering font shapes, introducing slight tilts, or using "dysfluent" typefaces introduces a persistent stream of low-level prediction errors.

    Micro-Surprisal: A letter that is tilted 5 degrees or has an irregular "handwritten" shape violates the strict geometric prior of the standard alphabet.

    Active Inference: To minimize this persistent error, the brain must engage Active Inference. It cannot simply rely on top-down predictions; it must actively sample the sensory evidence with higher precision.

This forces the reader into a state of heightened vigilance. The "noise" or irregularity in the font acts as a "teaching signal," commanding the attentional network to remain online to resolve the visual discrepancy. This upregulation of sensory precision prevents the collapse of attention associated with habituation.

4. The Locus Coeruleus-Norepinephrine (LC-NE) System

The mechanism by which "typographic surprise" translates into sustained attention is mediated neurochemically by the Locus Coeruleus (LC), the primary source of norepinephrine (NE) in the cortex. The interaction between font irregularity and LC dynamics is crucial for understanding reading improvements in ADHD.

4.1 Phasic vs. Tonic Modes of the LC

The LC operates in two distinct firing modes that correlate with behavioral states:

    Tonic Mode: A baseline rate of firing.

        Low Tonic: Associated with drowsiness, inattention, and non-alert states.

        High Tonic: Associated with distractibility, anxiety, and scanning behavior (lability).

    Phasic Mode: Bursts of high-frequency activity in response to task-relevant or salient stimuli. This mode optimizes task performance.

4.2 The Adaptive Gain Theory

The Adaptive Gain Theory proposes that phasic NE release optimizes the "gain" of the neural response function.

    Signal Enhancement: NE enhances the response to the target stimulus (the letter being read).

    Noise Suppression: NE suppresses spontaneous background activity (neural noise).
    This increases the Signal-to-Noise Ratio (SNR) within the sensory cortex, facilitating precise processing.

4.3 Pharmacological Parallels: Typography as Stimulant

Stimulant medications for ADHD (e.g., Methylphenidate) work by blocking the reuptake of dopamine and norepinephrine, effectively increasing their availability and stabilizing the LC in an optimal state.
Typographic Novelty functions as a sensory-based parallel to this pharmacological mechanism.

    The Novelty Trigger: The LC receives direct input from the prefrontal cortex and superior colliculus regarding stimulus salience. "Novel" stimuli trigger phasic LC bursts.

The "Snake Raised Its Head" Effect: Studies show that introducing content novelty in reading passages significantly improves performance in ADHD students by meeting their need for stimulation.

    Visual Novelty: Irregular or "tilted" fonts provide a constant stream of visual novelty. Each letter presents a slight deviation from the norm, triggering a micro-phasic burst of NE. This keeps the LC "engaged," preventing the slide into a low-tonic, inattentive state.

4.4 Adrenergic Receptor Distribution and Layer-Specific Effects

The impact of this NE release is layer-specific within the cortex, influencing how sensory data is processed.

Cortical Layer	Receptor Density	Functional Effect of NE
Layer 2/3 (Superficial)	High α1, High β, Low α2	Signal Integration: Enhances associative processing and communication between cortical areas.
Layer 4 (Input)	Low α1, Low α2, Low β	Sensory Gating: Less direct modulation, preserving the raw fidelity of the bottom-up input.
Layer 5/6 (Deep)	Mod-High α1, Low α2, Mod β	Output Modulation: Facilitates the "broadcast" of the processed signal to other brain regions.

By driving NE release, irregular typography specifically enhances activity in the superficial and deep layers, promoting the integration of the visual symbol with higher-order cognitive networks (semantic/phonological) while maintaining a high SNR.
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
    final headerRegex = RegExp(r'^\d+(\.\d+)*');

    for (var paragraph in _paragraphs) {
      if (paragraph.trim().isEmpty) continue;

      // Check if it's a header
      if (headerRegex.hasMatch(paragraph)) {
        paragraphWidgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              paragraph,
              style: GoogleFonts.orbitron(
                color: Colors.cyanAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ).animate().shimmer(duration: 2000.ms, color: Colors.purpleAccent),
          ),
        );
      } else {
        // Normal paragraph
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
