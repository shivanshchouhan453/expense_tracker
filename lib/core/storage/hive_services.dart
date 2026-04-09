import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';
import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String transactionBoxName = 'transactions';
  static const String categoryBoxName = 'categories';
  static const String settingsBoxName = 'settings';
  static const String userBoxName = 'users';

  static Future<void> init() async {
    await Hive.initFlutter();

    // register adapters
    Hive.registerAdapter(TransactionEntityAdapter());
    Hive.registerAdapter(CategoryEntityAdapter());
    Hive.registerAdapter(UserEntityAdapter());

    // open boxes to get the access of boxes
    await Hive.openBox<TransactionEntity>(transactionBoxName);
    await Hive.openBox<CategoryEntity>(categoryBoxName);
    await Hive.openBox(settingsBoxName);
    await Hive.openBox<UserEntity>(userBoxName);
  }

  static Box<TransactionEntity> getTransactionBox() {
    return Hive.box<TransactionEntity>(transactionBoxName);
  }

  static Box<CategoryEntity> getCategoryBox() {
    return Hive.box<CategoryEntity>(categoryBoxName);
  }

  static Future<Box<UserEntity>> getUserBox() async {
    return Hive.box<UserEntity>(userBoxName);
  }

  static Box getSettingsBox() {
    return Hive.box(settingsBoxName);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
