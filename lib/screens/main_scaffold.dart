import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../theme/app_theme.dart';
import '../services/pdf_service.dart';
import 'home_screen.dart'; // Will be "Spaces" view
import 'reader_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  final PdfService _pdfService = PdfService();
  bool _isProcessing = false;

  final List<Widget> _screens = [
    const HomeScreen(), // My Spaces
    const Center(child: Text("Settings Placeholder")), // Settings
  ];

  Future<void> _addNewSource() async {
    setState(() => _isProcessing = true);
    try {
      final file = await _pdfService.pickPdfFile();
      if (file != null) {
        // In a real app, we'd add this to a "Spaces" list here.
        // For now, we open it directly as a "New Space".
        final processedPdf = await _pdfService.extractText(file);

        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReaderScreen(processedPdf: processedPdf),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load PDF: $e"),
            backgroundColor: ReedarColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReedarColors.cream,
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: ReedarColors.latte.withOpacity(0.3),
        elevation: 0,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        indicatorColor: ReedarColors.matcha.withOpacity(0.5),
        destinations: const [
          NavigationDestination(
            icon: Icon(IconlyLight.home),
            selectedIcon: Icon(IconlyBold.home),
            label: 'Spaces',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.setting),
            selectedIcon: Icon(IconlyBold.setting),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isProcessing ? null : _addNewSource,
        backgroundColor: ReedarColors.mocha,
        foregroundColor: ReedarColors.cream,
        elevation: 4,
        icon: _isProcessing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: ReedarColors.cream,
                  strokeWidth: 2,
                ),
              )
            : const Icon(Icons.add),
        label: Text(
          _isProcessing ? "Processing..." : "New Source",
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
