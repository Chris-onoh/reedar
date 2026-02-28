import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconly/iconly.dart';

import '../theme/app_theme.dart';
import '../widgets/glass_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReedarColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Spaces",
                      style: GoogleFonts.outfit(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: ReedarColors.mocha,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: ReedarColors.mocha,
                      radius: 20,
                      child: Text(
                        "A",
                        style: GoogleFonts.outfit(
                          color: ReedarColors.cream,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Search Bar Placeholder
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 600),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search your notebooks...",
                      hintStyle: GoogleFonts.outfit(
                        color: ReedarColors.charcoal.withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      icon: Icon(
                        IconlyLight.search,
                        color: ReedarColors.mocha.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Recent Spaces Grid
              Expanded(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 600),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                    children: [
                      // Example Cards
                      _buildSpaceCard(
                        title: "Quantum Physics",
                        subtitle: "3 sources",
                        color: ReedarColors.sage.withOpacity(0.3),
                        icon: IconlyBold.paper,
                      ),
                      _buildSpaceCard(
                        title: "Vegan Recipes",
                        subtitle: "12 sources",
                        color: ReedarColors.latte.withOpacity(0.5),
                        icon: IconlyBold.heart,
                      ),
                      _buildSpaceCard(
                        title: "Project Alpha",
                        subtitle: "Updated 2m ago",
                        color: Colors.blueGrey.withOpacity(0.1),
                        icon: IconlyBold.work,
                      ),
                      _buildSpaceCard(
                        title: "Dart Guide",
                        subtitle: "Reference",
                        color: ReedarColors.matcha.withOpacity(0.4),
                        icon: IconlyBold.bookmark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpaceCard({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            // Open space detail (placeholder)
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: ReedarColors.mocha),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ReedarColors.mocha,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: ReedarColors.charcoal.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
