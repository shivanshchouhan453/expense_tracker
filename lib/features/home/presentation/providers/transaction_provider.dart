import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/features/home/presentation/providers/transaction_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Get all transactions
final allTransactionsProvider = FutureProvider<List<TransactionEntity>>((
  ref,
) async {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.getAllTransactions();
});

// Watch all transactions
final watchTransactionsProvider = StreamProvider<List<TransactionEntity>>((
  ref,
) {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.watchTransactions();
});

// Get transactions by month
final transactionsByMonthProvider =
    FutureProvider.family<List<TransactionEntity>, DateTime>((
      ref,
      month,
    ) async {
      final repo = ref.watch(transactionRepositoryProvider);
      return repo.getTransactionsByMonth(month);
    });

// Watch transactions by month
final watchTransactionsByMonthProvider =
    StreamProvider.family<List<TransactionEntity>, DateTime>((ref, month) {
      final repo = ref.watch(transactionRepositoryProvider);
      return repo.watchTransactions().map((transactions) {
        return transactions
            .where(
              (t) => t.date.year == month.year && t.date.month == month.month,
            )
            .toList();
      });
    });

// Add transaction
final addTransactionProvider = FutureProvider.family<void, TransactionEntity>((
  ref,
  transaction,
) async {
  final repo = ref.watch(transactionRepositoryProvider);
  await repo.addTransaction(transaction);
  // Invalidate related providers
  ref.invalidate(watchTransactionsProvider);
  ref.invalidate(allTransactionsProvider);
  ref.invalidate(
    watchTransactionsByMonthProvider(
      DateTime(transaction.date.year, transaction.date.month),
    ),
  );
});

// Update transaction
final updateTransactionProvider =
    FutureProvider.family<void, TransactionEntity>((ref, transaction) async {
      final repo = ref.watch(transactionRepositoryProvider);
      await repo.updateTransaction(transaction);
      ref.invalidate(watchTransactionsProvider);
      ref.invalidate(allTransactionsProvider);
    });

// Delete transaction
final deleteTransactionProvider = FutureProvider.family<void, String>((
  ref,
  id,
) async {
  final repo = ref.watch(transactionRepositoryProvider);
  await repo.deleteTransaction(id);
  ref.invalidate(watchTransactionsProvider);
  ref.invalidate(allTransactionsProvider);
});

// Current month provider
final currentMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month);
});

// Monthly summary
final monthlySummaryProvider =
    FutureProvider<({double income, double expense})>((ref) async {
      final month = ref.watch(currentMonthProvider);
      final transactions = await ref.watch(
        transactionsByMonthProvider(month).future,
      );

      double income = 0;
      double expense = 0;

      for (final t in transactions) {
        if (t.isIncome) {
          income += t.amount;
        } else {
          expense += t.amount;
        }
      }

      return (income: income, expense: expense);
    });
