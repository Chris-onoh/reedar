import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NeuralSyncIndicator extends StatelessWidget {
  final bool synced;

  const NeuralSyncIndicator({super.key, this.synced = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: synced
              ? Colors.greenAccent
              : Colors.redAccent.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(4),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            synced ? Icons.waves : Icons.warning_amber_rounded,
            size: 14,
            color: synced ? Colors.greenAccent : Colors.redAccent,
          ).animate(onPlay: (c) => c.repeat()).fade(duration: 1000.ms),
          const SizedBox(width: 6),
          Text(
            synced ? "NEURAL SYNC: OPTIMAL" : "SYNCING...",
            style: TextStyle(
              color: synced ? Colors.greenAccent : Colors.redAccent,
              fontSize: 10,
              fontFamily: 'Courier',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
