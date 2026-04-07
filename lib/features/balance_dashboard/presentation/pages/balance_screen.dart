import 'package:expense_tracker/features/balance_dashboard/presentation/widgets/summary_card.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker"), centerTitle: true),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SummaryCard(
              title: 'Your Balances',
              subtitle: 'Manage your accounts',
              income: 2000,
              expense: 1000,
              balance: 10000,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
