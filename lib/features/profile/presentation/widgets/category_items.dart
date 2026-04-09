import 'package:expense_tracker/core/utils/color_utils.dart';
import 'package:expense_tracker/core/widgets/build_icon_widget.dart';
import 'package:expense_tracker/core/navigation/animated_page_route.dart';
import 'package:expense_tracker/features/profile/presentation/pages/add_category_screen.dart';
import 'package:expense_tracker/features/profile/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryItem extends ConsumerWidget {
  final dynamic category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    AnimatedPageRoute(
                      builder: (context) =>
                          AddCategoryScreen(category: category),
                      animationType: AnimationType.slideUp,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(deleteCategoryProvider(category.id));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${category.name} deleted')),
                  );
                },
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade800
                : Colors.grey.shade200,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorUtils.parse(category.color),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: 40,
                height: 40,
                child: buildIconWidget(category.icon),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
