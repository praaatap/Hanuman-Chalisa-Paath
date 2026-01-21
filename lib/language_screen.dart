import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/particle_background.dart';
import 'reading_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'Hindi (Devanagari)';

  final List<Map<String, String>> _languages = [
    {'title': 'Hindi (Devanagari)', 'subtitle': 'Original sacred script'},
    {'title': 'Hindi + Meaning', 'subtitle': 'With English translation'},
    {'title': 'English Transliteration', 'subtitle': 'Phonetic reading'},
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF161213)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const Opacity(
              opacity: 0.1,
              child: ParticleBackground(color: primaryColor),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF161213),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 20),
                  Text(
                        'LANGUAGE',
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: primaryColor.withValues(alpha: 0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideX(begin: -0.2, end: 0),
                  const SizedBox(height: 12),
                  Text(
                        'Choose your\nreading script',
                        style: GoogleFonts.newsreader(
                          textStyle: const TextStyle(
                            color: Color(0xFF161213),
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 800.ms)
                      .slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 32),
                  ...List.generate(_languages.length, (index) {
                    final lang = _languages[index];
                    final isSelected = _selectedLanguage == lang['title'];
                    return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedLanguage = lang['title']!;
                              });
                            },
                            child: AnimatedContainer(
                              duration: 300.ms,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFFFF9F0)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? primaryColor
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? primaryColor.withValues(alpha: 0.15)
                                        : Colors.black.withValues(alpha: 0.03),
                                    blurRadius: isSelected ? 20 : 10,
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
                                    child: Icon(
                                      index == 0
                                          ? Icons.auto_stories
                                          : (index == 1
                                                ? Icons.translate
                                                : Icons.spellcheck),
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.grey,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang['title']!,
                                          style: GoogleFonts.manrope(
                                            textStyle: TextStyle(
                                              color: const Color(0xFF161213),
                                              fontSize: 18,
                                              fontWeight: isSelected
                                                  ? FontWeight.w800
                                                  : FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          lang['subtitle']!,
                                          style: GoogleFonts.newsreader(
                                            textStyle: TextStyle(
                                              color: const Color(
                                                0xFF5A5A5A,
                                              ).withValues(alpha: 0.7),
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 28,
                                    ).animate().scale(
                                      begin: const Offset(0.5, 0.5),
                                      end: const Offset(1, 1),
                                      curve: Curves.elasticOut,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: (600 + index * 100).ms)
                        .slideY(begin: 0.1, end: 0);
                  }),
                  const SizedBox(height: 48),
                  SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ReadingScreen(language: _selectedLanguage),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: primaryColor.withValues(alpha: 0.4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Begin Journey',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 1.seconds)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
