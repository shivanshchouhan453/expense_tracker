import 'package:expense_tracker/features/profile/domin/entities/category_entity.dart';

class DefaultCategories {
  static List<CategoryEntity> getDefaultCategories() {
    return [
      // Expense categories
      CategoryEntity(
        id: 'food',
        name: 'Food & Dining',
        icon: 'assets/icons/category_icons/fast_food.png',
        color: '#FF6B6B',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'transport',
        name: 'Transport',
        icon: 'assets/icons/category_icons/sport_car.png',
        color: '#4ECDC4',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'entertainment',
        name: 'Entertainment',
        icon: 'assets/icons/category_icons/clapperboard.png',
        color: '#FFE66D',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'shopping',
        name: 'Shopping',
        icon: 'assets/icons/category_icons/online_shopping.png',
        color: '#FF69B4',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'utilities',
        name: 'Utilities',
        icon: 'assets/icons/category_icons/idea.png',
        color: '#00D4FF',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'health',
        name: 'Health & Fitness',
        icon: 'assets/icons/category_icons/hospital.png',
        color: '#00E676',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'education',
        name: 'Education',
        icon: 'assets/icons/category_icons/books.png',
        color: '#7C3AED',
        isIncome: false,
      ),
      CategoryEntity(
        id: 'travel',
        name: 'Travel',
        icon: 'assets/icons/category_icons/airplane.png',
        color: '#F97316',
        isIncome: false,
      ),
      // Income categories
      CategoryEntity(
        id: 'salary',
        name: 'Salary',
        icon: 'assets/icons/category_icons/briefcase.png',
        color: '#00E676',
        isIncome: true,
      ),
      CategoryEntity(
        id: 'freelance',
        name: 'Freelance',
        icon: 'assets/icons/category_icons/programming.png',
        color: '#1DE9B6',
        isIncome: true,
      ),
      CategoryEntity(
        id: 'investment',
        name: 'Investment',
        icon: 'assets/icons/category_icons/stock.png',
        color: '#00D4FF',
        isIncome: true,
      ),
      CategoryEntity(
        id: 'bonus',
        name: 'Bonus',
        icon: 'assets/icons/category_icons/giftbox.png',
        color: '#FFD700',
        isIncome: true,
      ),
    ];
  }
}
