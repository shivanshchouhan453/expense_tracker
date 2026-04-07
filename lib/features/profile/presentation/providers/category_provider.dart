import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Get all categories
final allCategoriesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getAllCategories();
});

// Watch all categories
final watchCategoriesProvider = StreamProvider<List<CategoryEntity>>((ref) {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.watchCategories();
});

// Get expense categories
final expenseCategoriesProvider = FutureProvider<List<CategoryEntity>>((
  ref,
) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getExpenseCategories();
});

// Get income categories
final incomeCategoriesProvider = FutureProvider<List<CategoryEntity>>((
  ref,
) async {
  final repo = ref.watch(categoryRepositoryProvider);
  return repo.getIncomeCategories();
});

// Add category
final addCategoryProvider = FutureProvider.family<void, CategoryEntity>((
  ref,
  category,
) async {
  final repo = ref.watch(categoryRepositoryProvider);
  await repo.addCategory(category);
  ref.invalidate(watchCategoriesProvider);
  ref.invalidate(allCategoriesProvider);
  ref.invalidate(expenseCategoriesProvider);
  ref.invalidate(incomeCategoriesProvider);
});

// Update category
final updateCategoryProvider = FutureProvider.family<void, CategoryEntity>((
  ref,
  category,
) async {
  final repo = ref.watch(categoryRepositoryProvider);
  await repo.updateCategory(category);
  ref.invalidate(watchCategoriesProvider);
  ref.invalidate(allCategoriesProvider);
});

// Delete category
final deleteCategoryProvider = FutureProvider.family<void, String>((
  ref,
  id,
) async {
  final repo = ref.watch(categoryRepositoryProvider);
  await repo.deleteCategory(id);
  ref.invalidate(watchCategoriesProvider);
  ref.invalidate(allCategoriesProvider);
});
