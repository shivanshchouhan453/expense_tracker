import 'package:expense_tracker/core/utils/image_paths.dart';
import 'package:expense_tracker/features/home/presentation/pages/add_transaction_screen.dart';
import 'package:expense_tracker/features/home/presentation/widgets/expense_income_card.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_provider.dart';
import 'package:expense_tracker/features/profile/presentation/widgets/category_grid.dart'
    show CategoryGrid;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(allCategoriesProvider);
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
      body: SingleChildScrollView(
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
                      // for (var t in transactions) {
                      //   if (t.isIncome) {
                      //     income += t.amount;
                      //   }
                      // }
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
                      // for (var t in transactions) {
                      //   if (!t.isIncome) {
                      //     expense += t.amount;
                      //   }
                      // }
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

            categoriesAsync.when(
              data: (categories) {
                final expenses = categories.where((c) => !c.isIncome).toList();
                final incomes = categories.where((c) => c.isIncome).toList();
                return Column(
                  children: [
                    if (expenses.isNotEmpty) ...[
                      Text(
                        'Expense Categories',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CategoryGrid(categories: expenses),
                      const SizedBox(height: 16),
                    ],
                    if (incomes.isNotEmpty) ...[
                      Text(
                        'Income Categories',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CategoryGrid(categories: incomes),
                    ],
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error: $error'),
            ),

            // if (sortedTransactions.isEmpty)
            //   Center(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 32),
            //       child: Column(
            //         children: [
            //           Text(
            //             '📭',
            //             style: Theme.of(context).textTheme.displayLarge,
            //           ),
            //           const SizedBox(height: 12),
            //           Text(
            //             'No transactions yet',
            //             style: Theme.of(context).textTheme.bodyMedium,
            //           ),
            //         ],
            //       ),
            //     ),
            //   )
            // else
            //   ListView.builder(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: sortedTransactions.length,
            //     itemBuilder: (context, index) {
            //       final transaction = sortedTransactions[index];
            //       final category = categoryMap[transaction.categoryId];

            //       return _TransactionTile(
            //         transaction: transaction,
            //         category: category,
            //       );
            //     },
            //   ),
          ],
        ),
      ),
    );
  }
}
