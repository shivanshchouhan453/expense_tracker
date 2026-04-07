import 'package:flutter/material.dart';

class ColorUtils {
  static const Color defaultCategoryColor = Color(0xFFFF6B6B);

  static Color parse(String? value, {Color fallback = defaultCategoryColor}) {
    if (value == null || value.trim().isEmpty) {
      return fallback;
    }

    final normalized = value.trim().replaceFirst('#', '');
    print("normalized : $normalized");

    if (normalized.startsWith('0x') || normalized.startsWith('0X')) {
      final parsed = int.tryParse(normalized.substring(2), radix: 16);
      print("parsed inside the on start : $parsed");
      return parsed == null ? fallback : Color(parsed);
    }

    if (normalized.length == 6) {
      final parsed = int.tryParse('FF$normalized', radix: 16);
      print("parsed inside the on length == 6: $parsed");

      return parsed == null ? fallback : Color(parsed);
    }

    if (normalized.length == 8) {
      final parsed = int.tryParse(normalized, radix: 16);
      print("parsed inside the on length == 8 : $parsed");

      return parsed == null ? fallback : Color(parsed);
    }

    return fallback;
  }
}
