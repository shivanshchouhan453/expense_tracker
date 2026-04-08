import 'package:expense_tracker/core/theme/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<dynamic> transactions;

  const WeeklyBarChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    // Group transactions by day of week
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final dailyExpenses = <int, double>{};

    for (int i = 0; i < 7; i++) {
      dailyExpenses[i] = 0;
    }

    for (var transaction in transactions) {
      if (!transaction.isIncome) {
        final dayDiff = transaction.date.difference(weekStart).inDays;
        if (dayDiff >= 0 && dayDiff < 7) {
          dailyExpenses[dayDiff] =
              (dailyExpenses[dayDiff] ?? 0) + transaction.amount;
        }
      }
    }

    final maxValue = dailyExpenses.values.isEmpty
        ? 1.0
        : dailyExpenses.values.reduce((a, b) => a > b ? a : b).toDouble();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: maxValue * 1.2,
          barGroups: List.generate(7, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: dailyExpenses[index]!,
                  color: AppTheme.gradientStart,
                  width: 12,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun',
                  ];
                  return Text(
                    days[value.toInt()],
                    style: const TextStyle(fontSize: 12),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '\$${value.toInt()}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: true, drawHorizontalLine: true),
        ),
      ),
    );
  }
}
