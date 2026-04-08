import 'package:expense_tracker/core/utils/image_paths.dart';
import 'package:expense_tracker/features/home/domain/entities/transaction_entity.dart';
import 'package:expense_tracker/core/widgets/type_button.dart';
import 'package:expense_tracker/features/home/presentation/providers/transaction_provider.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  final TransactionEntity? transaction;

  const AddTransactionScreen({super.key, this.transaction});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;
  late DateTime _selectedDate;
  late bool _isIncome;
  late String _selectedCategoryId;
  late bool _isRecurring;
  late String _recurringType;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
    _selectedDate = DateTime.now();
    _isIncome = false;
    _selectedCategoryId = '';
    _isRecurring = false;
    _recurringType = 'monthly';

    if (widget.transaction != null) {
      _amountController.text = widget.transaction!.amount.toString();
      _noteController.text = widget.transaction!.note;
      _selectedDate = widget.transaction!.date;
      _isIncome = widget.transaction!.isIncome;
      _selectedCategoryId = widget.transaction!.categoryId;
      _isRecurring = widget.transaction!.isRecurring;
      _recurringType = widget.transaction!.recurringType ?? 'monthly';
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(watchCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.transaction == null ? 'Add Transaction' : 'Edit Transaction',
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: categoriesAsync.when(
        data: (categories) {
          final filteredCategories = _isIncome
              ? categories.where((c) => c.isIncome).toList()
              : categories.where((c) => !c.isIncome).toList();

          final uniqueCatgories = {
            for (final category in filteredCategories) category.id: category,
          }.values.toList();
          final hasValidSelection = uniqueCatgories.any(
            (category) => category.id == _selectedCategoryId,
          );

          if ((_selectedCategoryId.isEmpty || !hasValidSelection) &&
              uniqueCatgories.isNotEmpty) {
            _selectedCategoryId = uniqueCatgories.first.id;
          }

          final dropDownValue =
              uniqueCatgories.any(
                (category) => category.id == _selectedCategoryId,
              )
              ? _selectedCategoryId
              : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type Toggle
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TypeButton(
                          label: 'Expense',
                          iconPath: ImagesPath.expenseImagePath,
                          isSelected: !_isIncome,
                          onTap: () => setState(() => _isIncome = false),
                        ),
                      ),
                      Expanded(
                        child: TypeButton(
                          label: 'Income',
                          iconPath: ImagesPath.incomeImagePath,
                          isSelected: _isIncome,
                          onTap: () => setState(() => _isIncome = true),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Amount
                Text(
                  'Amount (Rupee)',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    prefix: const Text('₹ '),
                  ),
                ),
                const SizedBox(height: 24),

                // Category
                Text(
                  'Category',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    hint: const Text('Select a category'),
                    items: uniqueCatgories.map((category) {
                      return DropdownMenuItem(
                        value: category.id,
                        child: Row(
                          children: [
                            Text(
                              category.icon,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 8),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCategoryId = value);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Date
                Text(
                  'Date',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('MMM d, yyyy').format(_selectedDate),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Note
                Text(
                  'Note (Optional)',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: const InputDecoration(hintText: 'Add a note...'),
                ),
                const SizedBox(height: 24),

                // Recurring
                // CheckboxListTile(
                //   value: _isRecurring,
                //   onChanged: (value) {
                //     setState(() => _isRecurring = value ?? false);
                //   },
                //   title: const Text('Recurring Transaction?'),
                //   controlAffinity: ListTileControlAffinity.leading,
                // ),
                // if (_isRecurring) ...[
                //   const SizedBox(height: 12),
                //   Text(
                //     'Frequency',
                //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                //   const SizedBox(height: 8),
                //   Container(
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).colorScheme.surface,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     padding: const EdgeInsets.symmetric(horizontal: 12),
                //     child: DropdownButton<String>(
                //       value: _recurringType,
                //       isExpanded: true,
                //       underline: const SizedBox.shrink(),
                //       items: const [
                //         DropdownMenuItem(value: 'daily', child: Text('Daily')),
                //         DropdownMenuItem(
                //           value: 'weekly',
                //           child: Text('Weekly'),
                //         ),
                //         DropdownMenuItem(
                //           value: 'monthly',
                //           child: Text('Monthly'),
                //         ),
                //       ],
                //       onChanged: (value) {
                //         if (value != null) {
                //           setState(() => _recurringType = value);
                //         }
                //       },
                //     ),
                //   ),
                // ],
                const SizedBox(height: 32),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveTransaction,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.transaction == null
                          ? 'Add Transaction'
                          : 'Update Transaction',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Future<void> _saveTransaction() async {
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter an amount')));
      return;
    }

    if (_selectedCategoryId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }

    final transaction = TransactionEntity(
      id: widget.transaction?.id ?? const Uuid().v4(),
      amount: double.parse(_amountController.text),
      categoryId: _selectedCategoryId,
      date: _selectedDate,
      note: _noteController.text,
      isIncome: _isIncome,
      isRecurring: _isRecurring,
      recurringType: _isRecurring ? _recurringType : null,
    );

    try {
      if (widget.transaction == null) {
        await ref.read(addTransactionProvider(transaction).future);
      } else {
        await ref.read(updateTransactionProvider(transaction).future);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save transaction: $error')),
      );
    }
  }
}
