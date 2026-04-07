import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<void> addCategory(CategoryEntity category);
  Future<void> updateCategory(CategoryEntity category);
  Future<void> deleteCategory(String id);
  Future<List<CategoryEntity>> getAllCategories();
  Future<List<CategoryEntity>> getExpenseCategories();
  Future<List<CategoryEntity>> getIncomeCategories();
  Stream<List<CategoryEntity>> watchCategories();
}
