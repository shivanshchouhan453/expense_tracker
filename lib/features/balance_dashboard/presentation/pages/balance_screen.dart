import 'package:expense_tracker/features/balance_dashboard/presentation/widgets/category_tiles.dart';
import 'package:expense_tracker/features/balance_dashboard/presentation/widgets/expense_pie_chart.dart';
import 'package:expense_tracker/features/balance_dashboard/presentation/widgets/summary_card.dart';
import 'package:expense_tracker/features/balance_dashboard/presentation/widgets/weekly_expenses_bar_charts.dart';
import 'package:expense_tracker/features/home/presentation/providers/transaction_provider.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceScreen extends ConsumerStatefulWidget {
  const BalanceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends ConsumerState<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    // get current month
    final currentMonth = ref.watch(currentMonthProvider);
    // get current month summary
    final summaryAsync = ref.watch(monthlySummaryProvider);
    // get current month transactions
    final transactionAsync = ref.watch(
      watchTransactionsByMonthProvider(currentMonth),
    );
    // get all categories
    final categoriesAsync = ref.watch(watchCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker"), centerTitle: true),

      body: summaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (summary) {
          return transactionAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text('Error: $error')),
            data: (transactions) {
              return categoriesAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
                data: (categories) {
                  // Create category map
                  final categoryMap = {for (var c in categories) c.id: c};

                  // calculate category-wise expenses
                  final expensesByCategory = <String, double>{};
                  for (var t in transactions.where((t) => !t.isIncome)) {
                    expensesByCategory[t.categoryId] =
                        (expensesByCategory[t.categoryId] ?? 0) + t.amount;
                    print(
                      "expense category id : ${expensesByCategory[t.categoryId]}",
                    );
                    print("amount is : ${t.amount}");
                  }
                  final balance = summary.income - summary.expense;
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SummaryCard(
                          title: 'Your Balances',
                          subtitle: 'Manage your accounts',
                          income: summary.income,
                          expense: summary.expense,
                          balance: balance,
                        ),
                        const SizedBox(height: 24),
                        // Pie Chart
                        if (transactions.isNotEmpty &&
                            expensesByCategory.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expenses Distribution',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 20),
                              ExpensesPieChart(
                                expensesByCategory: expensesByCategory,
                                categoryMap: categoryMap,
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),

                        // Category Breakdown
                        Text(
                          'Category Breakdown',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        if (expensesByCategory.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Text(
                                'No expenses yet',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: expensesByCategory.length,
                            itemBuilder: (context, index) {
                              final entries = expensesByCategory.entries
                                  .toList();
                              final categoryId = entries[index].key;
                              final amount = entries[index].value;
                              final category = categoryMap[categoryId];
                              final percentage =
                                  (amount / summary.expense * 100);

                              return CategoryTiles(
                                category: category,
                                amount: amount,
                                percentage: percentage,
                                total: summary.expense,
                              );
                            },
                          ),
                        const SizedBox(height: 24),

                        // Weekly Bar Chart
                        if (transactions.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Expenses',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              WeeklyBarChart(transactions: transactions),
                              const SizedBox(height: 32),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
