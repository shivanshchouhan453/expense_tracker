import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/core/utils/color_utils.dart';
import 'package:expense_tracker/core/utils/image_paths.dart';
import 'package:expense_tracker/features/home/presentation/pages/add_transaction_screen.dart';
import 'package:expense_tracker/features/home/presentation/providers/transaction_provider.dart';
import 'package:expense_tracker/features/home/presentation/widgets/expense_income_card.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionsAsync = ref.watch(
      watchTransactionsByMonthProvider(
        DateTime(DateTime.now().year, DateTime.now().month),
      ),
    );
    final categoriesAsync = ref.watch(watchCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: transactionsAsync.when(
        data: (transactions) {
          final sortedTranscation = List.from(transactions)
            ..sort((a, b) => b.date.compareTo(a.date));
          return categoriesAsync.when(
            data: (categories) {
              final categoryMap = {for (var c in categories) c.id: c};
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Hey, User!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add your\'s expense',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),

                    // Income and Expense cards
                    Row(
                      children: [
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              double income = 0;
                              for (var t in transactions) {
                                if (t.isIncome) {
                                  income += t.amount;
                                }
                              }
                              return ExpenseIncomeCard(
                                label: 'Income',
                                amount: income,
                                iconPath: ImagesPath.incomeImagePath,
                                color: Colors.green,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Builder(
                            builder: (_) {
                              double expense = 0;
                              for (var t in transactions) {
                                if (!t.isIncome) {
                                  expense += t.amount;
                                }
                              }
                              return ExpenseIncomeCard(
                                label: 'Expense',
                                amount: expense,
                                iconPath: ImagesPath.expenseImagePath,
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Transactions List
                    Text(
                      'Your Transactions',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    if (sortedTranscation.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              Text(
                                '📭',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No transactions yet',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sortedTranscation.length,
                        itemBuilder: (context, index) {
                          final transaction = sortedTranscation[index];
                          final category = categoryMap[transaction.categoryId];

                          return _TransactionTile(
                            transaction: transaction,
                            category: category,
                          );
                        },
                      ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final dynamic transaction;
  final dynamic category;

  const _TransactionTile({required this.transaction, required this.category});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorUtils.parse(
                category?.color,
                fallback: const Color(0xFF6B7280),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category?.icon ?? '💰',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category?.name ?? 'Transaction',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (transaction.note.isNotEmpty)
                  Text(
                    transaction.note,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  DateFormat('MMM d, yyyy').format(transaction.date),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            '${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: transaction.isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
