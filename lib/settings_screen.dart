import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'logic/app_settings.dart';
import 'logic/app_strings.dart';

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
        title: ListenableBuilder(
          listenable: AppSettings(),
          builder: (context, child) {
            return Text(
              AppStrings.get('settings_title', AppSettings().appLanguage),
              style: GoogleFonts.newsreader(
                textStyle: const TextStyle(
                  color: Color(0xFF161213),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
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
                _buildSectionHeader(
                  AppStrings.get('reading_comfort', settings.appLanguage),
                ),
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
                            AppStrings.get('text_size', settings.appLanguage),
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
                        AppStrings.get('app_language', settings.appLanguage),
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF161213),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Toggle between English and Hindi
                          final newLang = settings.appLanguage == 'English'
                              ? 'Hindi'
                              : 'English';
                          settings.setAppLanguage(newLang);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: primaryColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                settings.appLanguage == 'Hindi'
                                    ? 'हिंदी'
                                    : 'English',
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.swap_horiz,
                                size: 16,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
                _buildSectionHeader(
                  AppStrings.get('experience', settings.appLanguage),
                ),
                const SizedBox(height: 16),

                // Show Meaning Card
                _buildCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.get('show_meaning', settings.appLanguage),
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
                            AppStrings.get(
                              'background_sound',
                              settings.appLanguage,
                            ),
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF161213),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppStrings.get(
                              'temple_ambience',
                              settings.appLanguage,
                            ),
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
                        AppStrings.get(
                          'app_title_english',
                          settings.appLanguage,
                        ),
                        style: GoogleFonts.newsreader(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.get(
                          'made_with_devotion',
                          settings.appLanguage,
                        ),
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
