import 'package:expense_tracker/features/profile/data/repositories/category_repository_impl.dart';
import 'package:expense_tracker/features/profile/domin/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl();
});
