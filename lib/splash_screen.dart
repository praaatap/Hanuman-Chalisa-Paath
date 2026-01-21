import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'breathing_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstRun();
  }

  Future<void> _checkFirstRun() async {
    // Artificial delay for splash effect
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool('is_first_run') ?? true;

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              isFirstRun ? const OnboardingScreen() : const BreathingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              // Floating/Pulsing Logo Container
              Stack(
                alignment: Alignment.center,
                children: [
                  // Soft outer glow
                  Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.15),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.15, 1.15),
                        duration: 2.seconds,
                        curve: Curves.easeInOut,
                      ),

                  // The New App Icon Image
                  Animate(
                    effects: [
                      FadeEffect(duration: 1.5.seconds),
                      ScaleEffect(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        duration: 1.5.seconds,
                        curve: Curves.easeOutBack,
                      ),
                    ],
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 160,
                      height: 160,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              // App Name
              Text(
                    'HANUMAN CHALISA',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                        color: Color(0xFF161213),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 6.0,
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 1.seconds)
                  .slideY(begin: 0.3, end: 0),
              const SizedBox(height: 12),
              Text(
                'Sacred Verses of Devotion',
                style: GoogleFonts.newsreader(
                  textStyle: TextStyle(
                    color: const Color(0xFF161213).withValues(alpha: 0.4),
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.5,
                  ),
                ),
              ).animate().fadeIn(delay: 1.2.seconds, duration: 1.seconds),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
