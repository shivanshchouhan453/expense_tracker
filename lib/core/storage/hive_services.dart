import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String transactionBoxName = 'transactions';
  static const String categoryBoxName = 'categories';
  static const String settingsBoxName = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(TransactionEntityAdapter());
    Hive.registerAdapter(CategoryEntityAdapter());

    // Open boxes
    await Hive.openBox<TransactionEntity>(transactionBoxName);
    await Hive.openBox<CategoryEntity>(categoryBoxName);
    await Hive.openBox(settingsBoxName);
  }

  static Box<TransactionEntity> getTransactionBox() {
    return Hive.box<TransactionEntity>(transactionBoxName);
  }

  static Box<CategoryEntity> getCategoryBox() {
    return Hive.box<CategoryEntity>(categoryBoxName);
  }

  static Box getSettingsBox() {
    return Hive.box(settingsBoxName);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
