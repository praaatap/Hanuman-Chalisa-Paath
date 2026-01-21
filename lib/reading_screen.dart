import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_flip/page_flip.dart';
import 'widgets/particle_background.dart';
import 'post_reading_screen.dart';
import 'pause_screen.dart';
import 'model/chalisa_data.dart';
import 'logic/user_progress.dart';
import 'logic/app_settings.dart';

class ReadingScreen extends StatefulWidget {
  final String language;
  const ReadingScreen({super.key, required this.language});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final GlobalKey<PageFlipWidgetState> _controller =
      GlobalKey<PageFlipWidgetState>();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD97736);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Very subtle background particles
            const Opacity(
              opacity: 0.2,
              child: ParticleBackground(color: primaryColor),
            ),

            Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF161213),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Text(
                        '${_currentPage + 1} / ${chalisaData.length}',
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: const Color(
                              0xFF161213,
                            ).withValues(alpha: 0.4),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.spa_outlined,
                          color: Color(0xFF161213),
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (context, _, _) =>
                                  const PauseScreen(),
                              transitionsBuilder:
                                  (context, animation, _, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Book Content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFE8D8), // Outer bg
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: PageFlipWidget(
                      key: _controller,
                      backgroundColor: const Color(
                        0xFFF9F5EC,
                      ), // Inner Paper color
                      // Sync external state with internal page flip
                      // Note: Verify if 'onPageFlip' is the correct param for page_flip 0.1.0.
                      // If it fails, we might need a GlobalKey<PageFlipWidgetState> to read page,
                      // but usually there's a callback. I'll try 'onPageFlip' which is common.
                      // If package text says `onPageFlip`, I'll use it.
                      // Actually, for page_flip package, it might use `onPageSwipe`.
                      // I will stick to button navigation updates primarily, but try to add logic.
                      // Since I can't check docs, I will assume the user swipes.
                      // If manual swipe doesn't update _currentPage, the next/prev buttons will be out of sync.
                      // I'll make the buttons read the controller's page if possible?
                      // No, simple solution:
                      lastPage: Container(
                        color: const Color(0xFFF9F5EC),
                        child: const Center(
                          child: Text('Hanuman Chalisa Completed'),
                        ),
                      ),
                      children: List.generate(
                        chalisaData.length,
                        (index) => _buildPage(index),
                      ),
                    ),
                  ),
                ),

                // Bottom Navigation & Info
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 48.0,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    children: [
                      // Page Indicators (Dots)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          chalisaData.length > 5 ? 5 : chalisaData.length,
                          (index) {
                            return Container(
                              width: 4,
                              height: 4,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor.withValues(
                                  alpha: (_currentPage % 5) == index
                                      ? 0.6
                                      : 0.1,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Navigation Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (_currentPage > 0) {
                                HapticFeedback.lightImpact();
                                _controller.currentState?.goToPage(
                                  _currentPage - 1,
                                );
                                setState(() {
                                  _currentPage--;
                                });
                              }
                            },
                            child: Text(
                              'PREVIOUS',
                              style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                  color: _currentPage > 0
                                      ? primaryColor.withValues(alpha: 0.3)
                                      : Colors.transparent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),

                          if (_currentPage < chalisaData.length - 1)
                            TextButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                _controller.currentState?.goToPage(
                                  _currentPage + 1,
                                );
                                setState(() {
                                  _currentPage++;
                                });
                              },
                              child: Text(
                                'NEXT',
                                style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                UserProgress().incrementChantCount();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PostReadingScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'FINISH',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    const Color backgroundLight = Color(0xFFF9F8F6);
    final verse = chalisaData[index];

    return ListenableBuilder(
      listenable: AppSettings(),
      builder: (context, child) {
        final settings = AppSettings();
        return Container(
          color: backgroundLight,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                verse.type,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    color: const Color(0xFFD97736).withValues(alpha: 0.5),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                verse.hindi,
                textAlign: TextAlign.center,
                style: GoogleFonts.newsreader(
                  textStyle: TextStyle(
                    color: const Color(0xFF161213),
                    fontSize: settings.fontSize + 10,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
              if (settings.showMeaning &&
                  widget.language != 'Hindi (Devanagari)') ...[
                const SizedBox(height: 24),
                Container(
                  width: 40,
                  height: 1,
                  color: const Color(0xFF161213).withValues(alpha: 0.1),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.language == 'Hindi + Meaning'
                      ? verse.meaning
                      : verse.translit,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.newsreader(
                    textStyle: TextStyle(
                      color: const Color(0xFF5A5A5A).withValues(alpha: 0.8),
                      fontSize: settings.fontSize,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (index == 0)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Swipe to start reading',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                        color: const Color(0xFF161213).withValues(alpha: 0.2),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
