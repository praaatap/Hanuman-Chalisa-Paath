import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/particle_background.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight.withValues(alpha: 0.95),
      body: Stack(
        children: [
          const ParticleBackground(color: primaryColor),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pause here.',
                  style: GoogleFonts.newsreader(
                    textStyle: const TextStyle(
                      color: Color(0xFF161213),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                Text(
                  'Take a breath.',
                  style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                      color: const Color(0xFF161213).withValues(alpha: 0.6),
                      fontSize: 14,
                      letterSpacing: 1.0,
                    ),
                  ),
                ).animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 64),
                OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primaryColor,
                        side: const BorderSide(color: primaryColor),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'RESUME',
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms)
                    .scale(begin: const Offset(0.9, 0.9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
