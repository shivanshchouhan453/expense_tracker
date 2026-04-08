import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';

class DefaultCategories {
  static List<CategoryEntity> getDefaultCategories() {
    return [
      // Expense categories
      CategoryEntity(
        id: 'food',
        name: 'Food & Dining',
        icon: '🍔',
        color: '#FF6B6B',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'transport',
        name: 'Transport',
        icon: '🚗',
        color: '#4ECDC4',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'entertainment',
        name: 'Entertainment',
        icon: '🎬',
        color: '#FFE66D',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'shopping',
        name: 'Shopping',
        icon: '🛍️',
        color: '#FF69B4',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'utilities',
        name: 'Utilities',
        icon: '💡',
        color: '#00D4FF',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'health',
        name: 'Health & Fitness',
        icon: '🏥',
        color: '#00E676',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'education',
        name: 'Education',
        icon: '📚',
        color: '#7C3AED',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'travel',
        name: 'Travel',
        icon: '✈️',
        color: '#F97316',
        isIncome: false,
      ),
      // Income categories
      CategoryEntity(
        id: 'salary',
        name: 'Salary',
        icon: '💼',
        color: '#00E676',
        isIncome: true,
      ),
      CategoryEntity(
        id: 'freelance',
        name: 'Freelance',
        icon: '💻',
        color: '#1DE9B6',
        isIncome: true,
      ),
      CategoryEntity(
        id: 'investment',
        name: 'Investment',
        icon: '📈',
        color: '#00D4FF',
        isIncome: true,
      ),
      CategoryEntity(
        id: 'bonus',
        name: 'Bonus',
        icon: '🎁',
        color: '#FFD700',
        isIncome: true,
      ),
    ];
  }
}
