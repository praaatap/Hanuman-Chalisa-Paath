import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'breathing_screen.dart';
import 'logic/app_settings.dart';
import 'logic/app_strings.dart';
import 'widgets/particle_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? _selectedLanguage;

  Future<void> _completeOnboarding() async {
    if (_selectedLanguage == null) return;

    // Save Language
    await AppSettings().setAppLanguage(_selectedLanguage!);

    // Set First Run to false
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_run', false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const BreathingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);
    final String currentLang = _selectedLanguage ?? 'English';

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          const ParticleBackground(color: primaryColor),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Logo or Icon
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 64,
                      height: 64,
                    ),
                  ).animate().fadeIn().scale(),

                  const SizedBox(height: 48),

                  Text(
                    AppStrings.get('welcome', currentLang),
                    style: GoogleFonts.newsreader(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF161213),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 16),

                  Text(
                    AppStrings.get('choose_language', currentLang),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: const Color(0xFF5A5A5A),
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 48),

                  // Language Options
                  _buildLanguageOption(
                    'English',
                    'Read in English script',
                    primaryColor,
                  ),
                  const SizedBox(height: 16),
                  _buildLanguageOption(
                    'Hindi',
                    'हिंदी लिपि में पढ़ें',
                    primaryColor,
                  ),

                  const Spacer(),

                  // Continue Button
                  AnimatedOpacity(
                    opacity: _selectedLanguage != null ? 1.0 : 0.0,
                    duration: 300.ms,
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _selectedLanguage != null
                            ? _completeOnboarding
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: primaryColor.withValues(alpha: 0.4),
                        ),
                        child: Text(
                          AppStrings.get('continue', currentLang),
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    String language,
    String subtitle,
    Color primaryColor,
  ) {
    bool isSelected = _selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF9F0) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? primaryColor.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor.withValues(alpha: 0.1)
                    : const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Text(
                language == 'English' ? 'A' : 'ॐ',
                style: GoogleFonts.newsreader(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? primaryColor : Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language,
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF161213),
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color: const Color(0xFF5A5A5A).withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: primaryColor,
                size: 24,
              ).animate().scale(curve: Curves.elasticOut),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0);
  }
}
