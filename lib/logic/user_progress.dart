import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class UserProgress extends ChangeNotifier {
  static final UserProgress _instance = UserProgress._internal();
  factory UserProgress() => _instance;
  UserProgress._internal() {
    _loadProgress();
  }

  static const String _keyChantCount = 'chant_count';
  int _chantCount = 0;

  int get chantCount => _chantCount;

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _chantCount = prefs.getInt(_keyChantCount) ?? 0;
    notifyListeners();
  }

  Future<void> incrementChantCount() async {
    _chantCount++;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyChantCount, _chantCount);
    notifyListeners();
  }
}
