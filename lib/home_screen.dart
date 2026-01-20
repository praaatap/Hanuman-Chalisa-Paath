import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'language_screen.dart';
import 'meaning_scroll_screen.dart';
import 'logic/user_progress.dart';

import 'widgets/particle_background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Floating Particles for "Life"
            const ParticleBackground(color: primaryColor),

            Center(
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  // Icon with subtle floating animation
                  const Icon(
                        Icons.self_improvement,
                        size: 48,
                        color: primaryColor,
                      )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .moveY(
                        begin: 0,
                        end: -10,
                        duration: 2.seconds,
                        curve: Curves.easeInOut,
                      )
                      .animate()
                      .fadeIn(duration: 1.seconds)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

                  const SizedBox(height: 40),

                  // Title
                  Column(
                        children: [
                          Text(
                            'हनुमान चालीसा',
                            style: GoogleFonts.newsreader(
                              textStyle: const TextStyle(
                                color: Color(0xFF161213),
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hanuman Chalisa',
                            style: GoogleFonts.newsreader(
                              textStyle: const TextStyle(
                                color: Color(0xFF5A5A5A),
                                fontSize: 24,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 1.seconds)
                      .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),

                  const SizedBox(height: 24),

                  // Chant Counter
                  AnimatedBuilder(
                    animation: UserProgress(),
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.incomplete_circle,
                              size: 16,
                              color: primaryColor.withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Completed: ${UserProgress().chantCount}',
                              style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                  color: primaryColor.withValues(alpha: 0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).animate().fadeIn(delay: 500.ms),

                  const SizedBox(height: 56),

                  // Buttons group
                  Column(
                        children: [
                          // Start Reading Button
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LanguageScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(200, 56),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'START READING',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Play Audio Button
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MeaningScrollScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_circle_outline,
                              color: primaryColor,
                              size: 24,
                            ),
                            label: Text(
                              'LISTEN TO CHALISA',
                              style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                  color: primaryColor.withValues(alpha: 0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 1.seconds)
                      .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),

                  const Spacer(flex: 4),
                ],
              ),
            ),

            // Footer
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterButton(
                      text: 'Language',
                      color: const Color(0xFF4A4A4A),
                    ),
                    const SizedBox(width: 32),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withValues(alpha: 0.2),
                      ),
                    ),
                    const SizedBox(width: 32),
                    _FooterButton(
                      text: 'Settings',
                      color: const Color(0xFF4A4A4A),
                    ),
                  ],
                ).animate().fadeIn(delay: 600.ms, duration: 1.seconds),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String text;
  final Color color;

  const _FooterButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
      child: Text(
        text,
        style: GoogleFonts.newsreader(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
