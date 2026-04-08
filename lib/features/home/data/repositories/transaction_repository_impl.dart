import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/home/domain/repository/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<void> addTransaction(TransactionEntity transaction) async {
    final box = HiveService.getTransactionBox();
    await box.put(transaction.id, transaction);
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
    final box = HiveService.getTransactionBox();
    await box.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final box = HiveService.getTransactionBox();
    await box.delete(id);
  }

  @override
  Future<List<TransactionEntity>> getAllTransactions() async {
    final box = HiveService.getTransactionBox();
    return box.values.toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByMonth(DateTime month) async {
    final box = HiveService.getTransactionBox();
    final all = box.values.toList();
    return all
        .where((t) => t.date.year == month.year && t.date.month == month.month)
        .toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByCategory(
    String categoryId,
  ) async {
    final box = HiveService.getTransactionBox();
    final all = box.values.toList();
    return all.where((t) => t.categoryId == categoryId).toList();
  }

  @override
  Stream<List<TransactionEntity>> watchTransactions() {
    final box = HiveService.getTransactionBox();
    return box.watch().map((_) => box.values.toList());
  }
}
