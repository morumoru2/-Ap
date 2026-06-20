import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/app_prefs.dart';

class SettingsState {
  final bool isDarkMode;
  final double fontSizeFactor;

  SettingsState({
    required this.isDarkMode,
    required this.fontSizeFactor,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    double? fontSizeFactor,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      fontSizeFactor: fontSizeFactor ?? this.fontSizeFactor,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(SettingsState(
          isDarkMode: AppPrefs.isDarkMode,
          fontSizeFactor: AppPrefs.fontSizeFactor,
        ));

  Future<void> toggleTheme() async {
    final next = !state.isDarkMode;
    state = state.copyWith(isDarkMode: next);
    await AppPrefs.setDarkMode(next);
  }

  Future<void> updateFontSize(double factor) async {
    state = state.copyWith(fontSizeFactor: factor);
    await AppPrefs.setFontSizeFactor(factor);
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
