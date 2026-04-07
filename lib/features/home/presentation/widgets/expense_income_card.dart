import 'package:expense_tracker/core/widgets/gredient_card.dart';
import 'package:flutter/material.dart';

class ExpenseIncomeCard extends StatelessWidget {
  final String label;
  final double amount;
  final String iconPath;
  final Color color;

  const ExpenseIncomeCard({
    super.key,
    required this.label,
    required this.amount,
    required this.iconPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradient: LinearGradient(
        colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(icon, style: const TextStyle(fontSize: 24)),
          Image.asset(iconPath, height: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
