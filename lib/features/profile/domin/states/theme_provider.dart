import 'package:expense_tracker/storage/hive_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<bool>((ref) {
  final settingsBox = HiveService.getSettingsBox();
  return settingsBox.get('isDarkMode', defaultValue: true);
});

final themeModeNotifierProvider =
    StateNotifierProvider<ThemeModeNotifier, bool>((ref) {
      return ThemeModeNotifier();
    });

class ThemeModeNotifier extends StateNotifier<bool> {
  ThemeModeNotifier() : super(_isDarkMode());

  static bool _isDarkMode() {
    final settingsBox = HiveService.getSettingsBox();
    return settingsBox.get('isDarkMode', defaultValue: true);
  }

  void toggleTheme() {
    state = !state;
    final settingsBox = HiveService.getSettingsBox();
    settingsBox.put('isDarkMode', state);
  }

  void setDarkMode(bool isDark) {
    state = isDark;
    final settingsBox = HiveService.getSettingsBox();
    settingsBox.put('isDarkMode', isDark);
  }
}
