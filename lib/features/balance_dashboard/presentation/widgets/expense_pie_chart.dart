import 'package:expense_tracker/core/utils/color_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesPieChart extends StatelessWidget {
  final Map<String, double> expensesByCategory;
  final Map<String, dynamic> categoryMap;

  const ExpensesPieChart({
    required this.expensesByCategory,
    required this.categoryMap,
  });

  @override
  Widget build(BuildContext context) {
    final total = expensesByCategory.values.fold<double>(0, (a, b) => a + b);
    final entries = expensesByCategory.entries.toList();

    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          sections: List.generate(entries.length, (index) {
            final amount = entries[index].value;
            final category = categoryMap[entries[index].key];
            final percentage = (amount / total * 100);

            return PieChartSectionData(
              value: percentage,
              title: '${percentage.toStringAsFixed(1)}%',
              color: ColorUtils.parse(
                category?.color,
                fallback: const Color(0xFF6B7280),
              ),
              radius: 100,
              titleStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }),
          centerSpaceRadius: 60,
        ),
      ),
    );
  }
}
