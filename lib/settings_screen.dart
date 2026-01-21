import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'logic/app_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.newsreader(
            textStyle: const TextStyle(
              color: Color(0xFF161213),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: AppSettings(),
        builder: (context, child) {
          final settings = AppSettings();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('READING COMFORT'),
                const SizedBox(height: 16),

                // Text Size Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Text Size',
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF161213),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              settings.fontSize.toInt().toString(),
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'A',
                            style: GoogleFonts.newsreader(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: primaryColor,
                                inactiveTrackColor: primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                thumbColor: Colors.white,
                                trackHeight: 2.0,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8.0,
                                  elevation: 2,
                                ),
                                overlayColor: primaryColor.withValues(
                                  alpha: 0.2,
                                ),
                                activeTickMarkColor: Colors.transparent,
                                inactiveTickMarkColor: Colors.transparent,
                                // Customizing the slider look to match image (orange dot in white thumb)
                              ),
                              child: Slider(
                                value: settings.fontSize,
                                min: 12,
                                max: 32,
                                onChanged: (value) =>
                                    settings.setFontSize(value),
                                thumbColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'A',
                            style: GoogleFonts.newsreader(
                              fontSize: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Language Selection Card
                _buildCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Language',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF161213),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Hindi',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                _buildSectionHeader('EXPERIENCE'),
                const SizedBox(height: 16),

                // Show Meaning Card
                _buildCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Show Meaning',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF161213),
                        ),
                      ),
                      Switch(
                        value: settings.showMeaning,
                        onChanged: (value) => settings.setShowMeaning(value),
                        activeColor: primaryColor,
                        activeTrackColor: primaryColor.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Background Sound Card
                _buildCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Background Sound',
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF161213),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Temple Ambience',
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: primaryColor.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: settings.backgroundSound,
                        onChanged: (value) =>
                            settings.setBackgroundSound(value),
                        activeColor: primaryColor,
                        activeTrackColor: primaryColor.withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),

                // Footer
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD97736),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Hanuman Chalisa',
                        style: GoogleFonts.newsreader(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'MADE WITH DEVOTION',
                        style: GoogleFonts.manrope(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.grey.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: Colors.grey.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
