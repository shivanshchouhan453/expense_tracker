import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarChart extends StatelessWidget {
  final List<TransactionEntity> transactions;

  const WeeklyBarChart({super.key, required this.transactions});

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  double _calculateInterval(double maxValue) {
    if (maxValue <= 0) return 1;
    return (maxValue / 3).ceilToDouble();
  }

  String _formatAxisAmount(double value) {
    if (value >= 1000) {
      final compactValue = value / 1000;
      final suffix = compactValue % 1 == 0
          ? compactValue.toStringAsFixed(0)
          : compactValue.toStringAsFixed(1);
      return '₹${suffix}K';
    }
    return '₹${value.toInt()}';
  }

  @override
  Widget build(BuildContext context) {
    final now = _dateOnly(DateTime.now());
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final dailyExpenses = <int, double>{};

    for (int i = 0; i < 7; i++) {
      dailyExpenses[i] = 0;
    }

    for (var transaction in transactions) {
      if (!transaction.isIncome) {
        final transactionDate = _dateOnly(transaction.date);
        final dayDiff = transactionDate.difference(weekStart).inDays;
        if (dayDiff >= 0 && dayDiff < 7) {
          dailyExpenses[dayDiff] =
              (dailyExpenses[dayDiff] ?? 0) + transaction.amount;
        }
      }
    }

    final maxExpense = dailyExpenses.values.isEmpty
        ? 0.0
        : dailyExpenses.values.reduce((a, b) => a > b ? a : b);
    final maxValue = maxExpense <= 0 ? 1.0 : maxExpense * 1.2;
    final interval = _calculateInterval(maxValue);

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: maxValue,
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
                reservedSize: 28,
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
                reservedSize: 52,
                interval: interval,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      _formatAxisAmount(value),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: interval,
          ),
        ),
      ),
    );
  }
}
