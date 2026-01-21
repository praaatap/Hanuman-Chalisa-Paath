import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static final AppSettings _instance = AppSettings._internal();
  factory AppSettings() => _instance;
  AppSettings._internal() {
    _loadSettings();
  }

  static const String _keyFontSize = 'settings_font_size';
  static const String _keyShowMeaning = 'settings_show_meaning';
  static const String _keyBackgroundSound = 'settings_background_sound';

  double _fontSize = 18.0;
  bool _showMeaning = true;
  bool _backgroundSound = false;

  double get fontSize => _fontSize;
  bool get showMeaning => _showMeaning;
  bool get backgroundSound => _backgroundSound;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble(_keyFontSize) ?? 18.0;
    _showMeaning = prefs.getBool(_keyShowMeaning) ?? true;
    _backgroundSound = prefs.getBool(_keyBackgroundSound) ?? false;
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
    notifyListeners();
  }
}
