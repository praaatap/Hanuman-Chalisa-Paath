import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PostReadingScreen extends StatelessWidget {
  const PostReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF591C28);
    const Color backgroundLight = Color(0xFFF9F8F6);

    return Scaffold(
      backgroundColor: backgroundLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.self_improvement, size: 48, color: primaryColor)
                .animate()
                .fadeIn(duration: 1.seconds)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  curve: Curves.elasticOut,
                ),

            const SizedBox(height: 32),

            Text(
              'Sit quietly for a moment.',
              textAlign: TextAlign.center,
              style: GoogleFonts.newsreader(
                textStyle: const TextStyle(
                  color: Color(0xFF5A5A5A),
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 1.5.seconds),

            const SizedBox(height: 64),

            TextButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text(
                'Return Home',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    color: primaryColor.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 2.seconds),
          ],
        ),
      ),
    );
  }
}
