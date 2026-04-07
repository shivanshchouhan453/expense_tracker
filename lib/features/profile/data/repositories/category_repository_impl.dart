import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';
import 'package:expense_tracker/features/profile/domin/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<void> addCategory(CategoryEntity category) async {
    try {
      final box = HiveService.getCategoryBox();
      await box.put(category.id, category);
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    try {
      final box = HiveService.getCategoryBox();
      await box.put(category.id, category);
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      final box = HiveService.getCategoryBox();
      await box.delete(id);
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    try {
      final box = HiveService.getCategoryBox();
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<List<CategoryEntity>> getExpenseCategories() async {
    try {
      final box = HiveService.getCategoryBox();
      final all = box.values.toList();
      return all.where((c) => !c.isIncome).toList();
    } catch (e) {
      throw Exception('Failed to fetch expense categories: $e');
    }
  }

  @override
  Future<List<CategoryEntity>> getIncomeCategories() async {
    try {
      final box = HiveService.getCategoryBox();
      final all = box.values.toList();
      return all.where((c) => c.isIncome).toList();
    } catch (e) {
      throw Exception('Failed to fetch income categories: $e');
    }
  }

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    try {
      final box = HiveService.getCategoryBox();
      return box.watch().map((_) => box.values.toList());
    } catch (e) {
      throw Exception('Failed to watch categories: $e');
    }
  }
}
