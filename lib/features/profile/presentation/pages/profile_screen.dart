import 'package:expense_tracker/core/widgets/gredient_card.dart';
import 'package:expense_tracker/features/profile/domin/states/theme_provider.dart';
import 'package:expense_tracker/features/profile/presentation/pages/add_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeNotifierProvider);
    // final categoriesAsync = ref.watch(watchCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            GradientCard(
              gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.cyan.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Text('👤', style: TextStyle(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shivansh Chouhan',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'shivanshchouhan453@gmail.com',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Settings
            Text(
              'Settings',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Dark Mode Toggle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: isDarkMode ? Colors.amber : Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Dark Mode',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      print("Dark Mode : $value");
                      ref
                          .read(themeModeNotifierProvider.notifier)
                          .setDarkMode(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AddCategoryScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // categoriesAsync.when(
            //   data: (categories) {
            //     final expenses = categories.where((c) => !c.isIncome).toList();
            //     final incomes = categories.where((c) => c.isIncome).toList();
            //     return Column(
            //       children: [
            //         if (expenses.isNotEmpty) ...[
            //           Text(
            //             'Expense Categories',
            //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //               fontWeight: FontWeight.w600,
            //               color: Colors.grey,
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //           _CategoryGrid(categories: expenses),
            //           const SizedBox(height: 16),
            //         ],
            //         if (incomes.isNotEmpty) ...[
            //           Text(
            //             'Income Categories',
            //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            //               fontWeight: FontWeight.w600,
            //               color: Colors.grey,
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //           _CategoryGrid(categories: incomes),
            //         ],
            //       ],
            //     );
            //   },
            //   loading: () => const CircularProgressIndicator(),
            //   error: (error, _) => Text('Error: $error'),
            // ),
            // const SizedBox(height: 32),

            // About Section
            // Text(
            //   'About',
            //   style: Theme.of(
            //     context,
            //   ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 12),
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.surface,
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(
            //       color: Theme.of(context).brightness == Brightness.dark
            //           ? Colors.grey.shade800
            //           : Colors.grey.shade200,
            //     ),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _InfoRow('App Version', '1.0.0'),
            //       const SizedBox(height: 12),
            //       _InfoRow('Build', '001'),
            //       const SizedBox(height: 12),
            //       _InfoRow('Privacy Policy', 'View →'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// class _CategoryGrid extends StatelessWidget {
//   final List<dynamic> categories;

//   const _CategoryGrid({required this.categories});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         mainAxisSpacing: 12,
//         crossAxisSpacing: 12,
//         childAspectRatio: 1.2,
//       ),
//       itemCount: categories.length,
//       itemBuilder: (context, index) {
//         final category = categories[index];
//         return _CategoryItem(category: category);
//       },
//     );
//   }
// }

// class _CategoryItem extends ConsumerWidget {
//   final dynamic category;

//   const _CategoryItem({required this.category});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return GestureDetector(
//       onLongPress: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (context) => Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.edit),
//                 title: const Text('Edit'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           AddCategoryScreen(category: category),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.delete, color: Colors.red),
//                 title: const Text(
//                   'Delete',
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   ref.read(deleteCategoryProvider(category.id));
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('${category.name} deleted')),
//                   );
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.grey.shade800
//                 : Colors.grey.shade200,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: ColorUtils.parse(category.color),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(category.icon, style: const TextStyle(fontSize: 24)),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               category.name,
//               style: Theme.of(
//                 context,
//               ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _InfoRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const _InfoRow(this.label, this.value);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
//         ),
//         Text(
//           value,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
//         ),
//       ],
//     );
//   }
// }
