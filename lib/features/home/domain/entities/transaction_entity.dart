import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
part 'transaction_entity.g.dart';

@HiveType(typeId: 0)
class TransactionEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String categoryId;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String note;

  @HiveField(5)
  final bool isIncome;

  @HiveField(6)
  final bool isRecurring;

  @HiveField(7)
  final String? recurringType; // daily, weekly, monthly

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.categoryId,
    required this.date,
    required this.note,
    required this.isIncome,
    this.isRecurring = false,
    this.recurringType,
  });

  TransactionEntity copyWith({
    String? id,
    double? amount,
    String? categoryId,
    DateTime? date,
    String? note,
    bool? isIncome,
    bool? isRecurring,
    String? recurringType,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      note: note ?? this.note,
      isIncome: isIncome ?? this.isIncome,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringType: recurringType ?? this.recurringType,
    );
  }
}
