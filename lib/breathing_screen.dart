import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_screen.dart';
import 'logic/app_settings.dart';
import 'logic/app_strings.dart';

import 'widgets/particle_background.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  bool _isBreatheIn = true;

  @override
  void initState() {
    super.initState();
    _startBreathingCycle();
  }

  void _startBreathingCycle() async {
    while (mounted) {
      await Future.delayed(4.seconds);
      if (!mounted) return;
      setState(() {
        _isBreatheIn = !_isBreatheIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: ListenableBuilder(
        listenable: AppSettings(),
        builder: (context, child) {
          final settings = AppSettings();
          final breatheText = _isBreatheIn
              ? AppStrings.get('breathe_in', settings.appLanguage)
              : AppStrings.get('breathe_out', settings.appLanguage);

          return Stack(
            children: [
              // Floating Particles for "Life"
              const ParticleBackground(color: primaryColor),

              // Background Glows
              Positioned.fill(
                child: Center(
                  child:
                      Container(
                            width: 600,
                            height: 600,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor.withValues(alpha: 0.05),
                            ),
                          )
                          .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                          )
                          .blur(
                            begin: const Offset(60, 60),
                            end: const Offset(100, 100),
                            duration: 4.seconds,
                          ),
                ),
              ),

              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                            breatheText,
                            key: ValueKey(_isBreatheIn),
                            style: GoogleFonts.newsreader(
                              textStyle: const TextStyle(
                                color: Color(0xFF161213),
                                fontSize: 48,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          .animate(key: ValueKey(_isBreatheIn))
                          .fadeIn(duration: 2.seconds)
                          .fadeOut(delay: 2.seconds, duration: 2.seconds),

                      const SizedBox(height: 16),

                      Text(
                        AppStrings.get('find_center', settings.appLanguage),
                        style: GoogleFonts.newsreader(
                          textStyle: TextStyle(
                            color: const Color(
                              0xFF5A5A5A,
                            ).withValues(alpha: 0.6),
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ).animate().fadeIn(delay: 500.ms, duration: 1.5.seconds),
                    ],
                  ),
                ),
              ),

              // Footer
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated New Logo at bottom
                      Opacity(
                            opacity: 0.6,
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 24,
                              height: 24,
                            ),
                          )
                          .animate(onPlay: (p) => p.repeat(reverse: true))
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1.1, 1.1),
                            duration: 2.seconds,
                          ),

                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          AppStrings.get('skip', settings.appLanguage),
                          style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                              color: const Color(
                                0xFF161213,
                              ).withValues(alpha: 0.4),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
