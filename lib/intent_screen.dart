import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntentScreen extends StatelessWidget {
  const IntentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Back Button
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF161213)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                          'Our Intent',
                          style: GoogleFonts.newsreader(
                            textStyle: const TextStyle(
                              color: Color(0xFF161213),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.2, end: 0),

                    const SizedBox(height: 16),

                    Container(
                          width: 40,
                          height: 1,
                          color: primaryColor.withValues(alpha: 0.3),
                        )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 800.ms)
                        .scaleX(begin: 0, end: 1),

                    const SizedBox(height: 48),

                    Text(
                      'This app exists to provide a focused, calm space for reading the Hanuman Chalisa. In a world of distraction, we wanted to build a sanctuary for your practice.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.newsreader(
                        textStyle: TextStyle(
                          color: const Color(0xFF161213).withValues(alpha: 0.7),
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                    ).animate().fadeIn(delay: 600.ms, duration: 1.seconds),

                    const SizedBox(height: 32),

                    Text(
                      'There are no ads, no tracking, and no distractions. Just the verses and your devotion.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.newsreader(
                        textStyle: TextStyle(
                          color: const Color(0xFF161213).withValues(alpha: 0.7),
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),
                    ).animate().fadeIn(delay: 1.seconds, duration: 1.seconds),

                    const SizedBox(height: 80),

                    // Logo at bottom
                    Opacity(
                          opacity: 0.6,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 32,
                            height: 32,
                          ),
                        )
                        .animate(onPlay: (p) => p.repeat(reverse: true))
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          end: const Offset(1.1, 1.1),
                          duration: 2.seconds,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
