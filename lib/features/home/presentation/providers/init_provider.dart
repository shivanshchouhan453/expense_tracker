import 'package:expense_tracker/core/constants/default_categories.dart';
import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initializeAppProvider = FutureProvider<void>((ref) async {
  // Initialize default categories if empty
  final box = HiveService.getCategoryBox();
  if (box.isEmpty) {
    final defaultCategories = DefaultCategories.getDefaultCategories();
    for (final category in defaultCategories) {
      await box.put(category.id, category);
    }
  }
});
