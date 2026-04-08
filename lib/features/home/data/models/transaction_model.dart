import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required String id,
    required double amount,
    required String categoryId,
    required DateTime date,
    required String note,
    required bool isIncome,
    bool isRecurring = false,
    String? recurringType,
  }) : super(
         id: id,
         amount: amount,
         categoryId: categoryId,
         date: date,
         note: note,
         isIncome: isIncome,
         isRecurring: isRecurring,
         recurringType: recurringType,
       );

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      categoryId: map['categoryId'] ?? '',
      date: map['date'] is DateTime
          ? map['date']
          : DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      note: map['note'] ?? '',
      isIncome: map['isIncome'] ?? false,
      isRecurring: map['isRecurring'] ?? false,
      recurringType: map['recurringType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'note': note,
      'isIncome': isIncome,
      'isRecurring': isRecurring,
      'recurringType': recurringType,
    };
  }
}
