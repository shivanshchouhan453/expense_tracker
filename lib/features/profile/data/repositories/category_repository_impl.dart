import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';
import 'package:expense_tracker/features/profile/domin/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<void> addCategory(CategoryEntity category) async {
    final box = HiveService.getCategoryBox();
    await box.put(category.id, category);
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    final box = HiveService.getCategoryBox();
    await box.put(category.id, category);
  }

  @override
  Future<void> deleteCategory(String id) async {
    final box = HiveService.getCategoryBox();
    await box.delete(id);
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final box = HiveService.getCategoryBox();
    return box.values.toList();
  }

  @override
  Future<List<CategoryEntity>> getExpenseCategories() async {
    final box = HiveService.getCategoryBox();
    final all = box.values.toList();
    return all.where((c) => !c.isIncome).toList();
  }

  @override
  Future<List<CategoryEntity>> getIncomeCategories() async {
    final box = HiveService.getCategoryBox();
    final all = box.values.toList();
    return all.where((c) => c.isIncome).toList();
  }

  @override
  Stream<List<CategoryEntity>> watchCategories() {
    final box = HiveService.getCategoryBox();
    return box.watch().map((_) => box.values.toList());
  }
}
