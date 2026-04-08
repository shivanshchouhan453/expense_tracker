import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(String id);
  Future<List<TransactionEntity>> getAllTransactions();
  Future<List<TransactionEntity>> getTransactionsByMonth(DateTime month);
  Future<List<TransactionEntity>> getTransactionsByCategory(String categoryId);
  Stream<List<TransactionEntity>> watchTransactions();
}
