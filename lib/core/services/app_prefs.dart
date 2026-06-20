import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  AppPrefs._();

  static const _tutorialCompletedKey = 'tutorial_completed';
  static const _darkModeKey = 'dark_mode';
  static const _fontSizeFactorKey = 'font_size_factor';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isTutorialCompleted =>
      _prefs?.getBool(_tutorialCompletedKey) ?? false;

  static Future<void> setTutorialCompleted(bool value) async {
    await _prefs?.setBool(_tutorialCompletedKey, value);
  }

  static bool get isDarkMode => _prefs?.getBool(_darkModeKey) ?? true;

  static Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool(_darkModeKey, value);
  }

  static double get fontSizeFactor =>
      _prefs?.getDouble(_fontSizeFactorKey) ?? 1.0;

  static Future<void> setFontSizeFactor(double value) async {
    await _prefs?.setDouble(_fontSizeFactorKey, value);
  }
}
