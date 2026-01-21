import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/particle_background.dart';
import 'logic/app_settings.dart';
import 'logic/app_strings.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight.withValues(alpha: 0.95),
      body: ListenableBuilder(
        listenable: AppSettings(),
        builder: (context, child) {
          final settings = AppSettings();
          return Stack(
            children: [
              const ParticleBackground(color: primaryColor),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                          AppStrings.get('pause_here', settings.appLanguage),
                          style: GoogleFonts.newsreader(
                            textStyle: const TextStyle(
                              color: Color(0xFF161213),
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 800.ms)
                        .slideY(begin: 0.1, end: 0),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.get('take_a_breath', settings.appLanguage),
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
                            AppStrings.get('resume', settings.appLanguage),
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
          );
        },
      ),
    );
  }
}
