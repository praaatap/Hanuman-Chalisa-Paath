import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class AppSettings extends ChangeNotifier {
  static final AppSettings _instance = AppSettings._internal();
  factory AppSettings() => _instance;
  AppSettings._internal() {
    _loadSettings();
  }

  static const String _keyFontSize = 'settings_font_size';
  static const String _keyShowMeaning = 'settings_show_meaning';
  static const String _keyBackgroundSound = 'settings_background_sound';
  static const String _keyAppLanguage = 'settings_app_language';

  double _fontSize = 20.0; // Increased default
  bool _showMeaning = true;
  bool _backgroundSound = false;
  String _appLanguage = 'English';

  final AudioPlayer _bgPlayer = AudioPlayer();

  double get fontSize => _fontSize;
  bool get showMeaning => _showMeaning;
  bool get backgroundSound => _backgroundSound;
  String get appLanguage => _appLanguage;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble(_keyFontSize) ?? 20.0;
    _showMeaning = prefs.getBool(_keyShowMeaning) ?? true;
    _backgroundSound = prefs.getBool(_keyBackgroundSound) ?? false;
    _appLanguage = prefs.getString(_keyAppLanguage) ?? 'English';

    // Initialize background sound if enabled
    if (_backgroundSound) {
      _playBackgroundSound();
    }

    notifyListeners();
  }

  Future<void> setFontSize(double value) async {
    _fontSize = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyFontSize, value);
    notifyListeners();
  }

  Future<void> setShowMeaning(bool value) async {
    _showMeaning = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyShowMeaning, value);
    notifyListeners();
  }

  Future<void> setBackgroundSound(bool value) async {
    _backgroundSound = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyBackgroundSound, value);

    if (value) {
      _playBackgroundSound();
    } else {
      _bgPlayer.stop();
    }

    notifyListeners();
  }

  Future<void> setAppLanguage(String value) async {
    _appLanguage = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAppLanguage, value);
    notifyListeners();
  }

  void _playBackgroundSound() async {
    // Use a loopable ambient track (e.g., Om Chanting or Flute)
    // Using a reliable source.
    try {
      await _bgPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgPlayer.setSource(
        UrlSource(
          'https://archive.org/download/OmChanting417Hz/Om%20Chanting%20417%20Hz.mp3',
        ),
      );
      await _bgPlayer.setVolume(0.3); // Low volume for background
      await _bgPlayer.resume();
    } catch (e) {
      debugPrint("Error playing background sound: $e");
    }
  }
}
