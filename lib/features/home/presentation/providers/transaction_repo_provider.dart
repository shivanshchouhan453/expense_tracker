import 'package:expense_tracker/features/home/data/repositories/transaction_repository_impl.dart';
import 'package:expense_tracker/features/home/domain/repository/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl();
});
