import 'package:expense_tracker/core/utils/color_utils.dart';
import 'package:expense_tracker/core/utils/image_paths.dart';
import 'package:expense_tracker/core/widgets/type_button.dart';
import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddCategoryScreen extends ConsumerStatefulWidget {
  final CategoryEntity? category;

  const AddCategoryScreen({super.key, this.category});

  @override
  ConsumerState<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<AddCategoryScreen> {
  late TextEditingController _nameController;
  late String _selectedIcon;
  late String _selectedColor;
  late bool _isIncome;

  static const List<String> icons = [
    '🍔',
    '🚗',
    '🎬',
    '🛍️',
    '💡',
    '🏥',
    '📚',
    '✈️',
    '💼',
    '💻',
    '📈',
    '🎁',
    '🎮',
    '🏋️',
    '🎵',
    '🎨',
    '🌮',
    '🏠',
    '💳',
    '🚀',
    '📱',
    '⚡',
    '🌍',
    '🎓',
  ];

  static const List<String> colors = [
    '#FF6B6B',
    '#4ECDC4',
    '#FFE66D',
    '#FF69B4',
    '#00D4FF',
    '#00E676',
    '#7C3AED',
    '#F97316',
    '#1DE9B6',
    '#0EA5E9',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _selectedIcon = widget.category?.icon ?? icons.first;
    _selectedColor = widget.category?.color ?? colors.first;
    _isIncome = widget.category?.isIncome ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Name
            Text(
              'Category Name',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'e.g., Food & Dining',
              ),
            ),
            const SizedBox(height: 24),

            // Type
            Text(
              'Type',
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

            // Icon Selection
            Text(
              'Choose Icon',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  final icon = icons[index];
                  final isSelected = _selectedIcon == icon;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIcon = icon),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(icon, style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Color Selection
            Text(
              'Choose Color',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: colors.map((color) {
                final isSelected = _selectedColor == color;

                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = color),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorUtils.parse(color),
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: ColorUtils.parse(color).withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                    child: isSelected
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24,
                            ),
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorUtils.parse(_selectedColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_selectedIcon, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 16),
                  Text(
                    _nameController.text.isEmpty
                        ? 'Preview'
                        : _nameController.text,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveCategory,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  widget.category == null ? 'Add Category' : 'Update Category',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveCategory() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a category name')),
      );
      return;
    }
    print("save categories into the db");
    final category = CategoryEntity(
      id: widget.category?.id ?? const Uuid().v4(),
      name: _nameController.text,
      icon: _selectedIcon,
      color: _selectedColor,
      isIncome: _isIncome,
    );
    print("category id is : ${category.id}");
    print("category name is : ${category.name}");
    print("category icon is : $_selectedIcon");
    print("category color is : $_selectedColor");
    print("is it income : $_isIncome");

    if (widget.category == null) {
      ref.read(addCategoryProvider(category));
    } else {
      ref.read(updateCategoryProvider(category));
    }

    Navigator.of(context).pop();
  }
}
