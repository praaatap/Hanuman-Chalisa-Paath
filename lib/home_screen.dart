import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'language_screen.dart';
import 'meaning_scroll_screen.dart';
import 'logic/user_progress.dart';
import 'settings_screen.dart';
import 'intent_screen.dart';

import 'widgets/particle_background.dart';
import 'logic/app_settings.dart';
import 'logic/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          return LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > 600;

              return SafeArea(
                child: Stack(
                  children: [
                    // Floating Particles
                    const ParticleBackground(color: primaryColor),

                    Center(
                      child: isLandscape
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Left Side: Title & Image
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                            'assets/images/logo.png',
                                            width: 80,
                                            height: 80,
                                          )
                                          .animate(
                                            onPlay: (c) =>
                                                c.repeat(reverse: true),
                                          )
                                          .moveY(
                                            begin: 0,
                                            end: -10,
                                            duration: 2.seconds,
                                          )
                                          .animate()
                                          .fadeIn()
                                          .slideY(begin: 0.2, end: 0),
                                      const SizedBox(height: 24),
                                      Text(
                                        AppStrings.get(
                                          'app_title_hindi',
                                          settings.appLanguage,
                                        ),
                                        style: GoogleFonts.newsreader(
                                          textStyle: const TextStyle(
                                            color: Color(0xFF161213),
                                            fontSize: 64,
                                            fontWeight: FontWeight.bold,
                                            height: 1.1,
                                          ),
                                        ),
                                      ).animate().fadeIn(delay: 200.ms),
                                      Text(
                                        AppStrings.get(
                                          'app_title_english',
                                          settings.appLanguage,
                                        ),
                                        style: GoogleFonts.newsreader(
                                          textStyle: const TextStyle(
                                            color: Color(0xFF5A5A5A),
                                            fontSize: 28,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ).animate().fadeIn(delay: 300.ms),
                                    ],
                                  ),
                                ),

                                // Right Side: Buttons & Stats
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Chant Counter
                                      AnimatedBuilder(
                                        animation: UserProgress(),
                                        builder: (context, child) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withValues(
                                                alpha: 0.05,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color: primaryColor.withValues(
                                                  alpha: 0.1,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.incomplete_circle,
                                                  size: 20,
                                                  color: primaryColor
                                                      .withValues(alpha: 0.6),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${AppStrings.get("completed", settings.appLanguage)}: ${UserProgress().chantCount}',
                                                  style: GoogleFonts.manrope(
                                                    textStyle: TextStyle(
                                                      color: primaryColor
                                                          .withValues(
                                                            alpha: 0.8,
                                                          ),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ).animate().fadeIn(delay: 400.ms),

                                      const SizedBox(height: 48),

                                      // Buttons
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: primaryColor.withValues(
                                                alpha: 0.1,
                                              ),
                                              blurRadius: 15,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LanguageScreen(),
                                                ),
                                              ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            foregroundColor: Colors.white,
                                            minimumSize: const Size(220, 60),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: Text(
                                            AppStrings.get(
                                              'start_reading',
                                              settings.appLanguage,
                                            ),
                                            style: GoogleFonts.manrope(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ).animate().fadeIn(delay: 500.ms),

                                      const SizedBox(height: 24),

                                      TextButton.icon(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MeaningScrollScreen(),
                                              ),
                                            ),
                                        icon: const Icon(
                                          Icons.play_circle_outline,
                                          color: primaryColor,
                                          size: 24,
                                        ),
                                        label: Text(
                                          AppStrings.get(
                                            'listen_chalisa',
                                            settings.appLanguage,
                                          ),
                                          style: GoogleFonts.manrope(
                                            textStyle: TextStyle(
                                              color: primaryColor.withValues(
                                                alpha: 0.6,
                                              ),
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2.0,
                                            ),
                                          ),
                                        ),
                                      ).animate().fadeIn(delay: 600.ms),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          // Portrait Layout
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                        'assets/images/logo.png',
                                        width: 64,
                                        height: 64,
                                      )
                                      .animate(
                                        onPlay: (c) => c.repeat(reverse: true),
                                      )
                                      .moveY(
                                        begin: 0,
                                        end: -10,
                                        duration: 2.seconds,
                                      )
                                      .animate()
                                      .fadeIn()
                                      .slideY(begin: 0.2, end: 0),

                                  const SizedBox(height: 40),

                                  Column(
                                        children: [
                                          Text(
                                            AppStrings.get(
                                              'app_title_hindi',
                                              settings.appLanguage,
                                            ),
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
                                            AppStrings.get(
                                              'app_title_english',
                                              settings.appLanguage,
                                            ),
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
                                      .fadeIn(delay: 200.ms)
                                      .slideY(begin: 0.1, end: 0),

                                  const SizedBox(height: 24),

                                  AnimatedBuilder(
                                    animation: UserProgress(),
                                    builder: (context, child) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withValues(
                                            alpha: 0.05,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: primaryColor.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.incomplete_circle,
                                              size: 16,
                                              color: primaryColor.withValues(
                                                alpha: 0.6,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              '${AppStrings.get("completed", settings.appLanguage)}: ${UserProgress().chantCount}',
                                              style: GoogleFonts.manrope(
                                                textStyle: TextStyle(
                                                  color: primaryColor
                                                      .withValues(alpha: 0.8),
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

                                  Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: primaryColor
                                                      .withValues(alpha: 0.1),
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
                                                minimumSize: const Size(
                                                  200,
                                                  56,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                elevation: 0,
                                              ),
                                              child: Text(
                                                AppStrings.get(
                                                  'start_reading',
                                                  settings.appLanguage,
                                                ),
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
                                              AppStrings.get(
                                                'listen_chalisa',
                                                settings.appLanguage,
                                              ),
                                              style: GoogleFonts.manrope(
                                                textStyle: TextStyle(
                                                  color: primaryColor
                                                      .withValues(alpha: 0.6),
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
                                      .fadeIn(delay: 400.ms)
                                      .slideY(begin: 0.1, end: 0),
                                ],
                              ),
                            ),
                    ),

                    // Footer
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _FooterButton(
                              text: AppStrings.get(
                                'language',
                                settings.appLanguage,
                              ),
                              color: const Color(0xFF4A4A4A),
                              originalKey: 'Language',
                            ),
                            const SizedBox(width: 24),
                            _FooterButton(
                              text: AppStrings.get(
                                'intent',
                                settings.appLanguage,
                              ),
                              color: const Color(0xFF4A4A4A),
                              originalKey: 'Intent',
                            ),
                            const SizedBox(width: 24),
                            _FooterButton(
                              text: AppStrings.get(
                                'settings',
                                settings.appLanguage,
                              ),
                              color: const Color(0xFF4A4A4A),
                              originalKey: 'Settings',
                            ),
                          ],
                        ).animate().fadeIn(delay: 600.ms),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String text;
  final Color color;
  final String originalKey;

  const _FooterButton({
    required this.text,
    required this.color,
    this.originalKey = '',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Use originalKey if available, otherwise fallback to text (to be safe, though usage passes keys)
        final key = originalKey.isNotEmpty ? originalKey : text;

        if (key == 'Language') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LanguageScreen()),
          );
        } else if (key == 'Settings') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        } else if (key == 'Intent') {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const IntentScreen()));
        }
      },
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
