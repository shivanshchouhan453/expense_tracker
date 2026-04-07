import 'package:hive/hive.dart';

part 'category_entity.g.dart';

@HiveType(typeId: 1)
class CategoryEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon; // emoji or icon name

  @HiveField(3)
  final String color; // hex color

  @HiveField(4)
  final bool isIncome;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.isIncome,
  });

  CategoryEntity copyWith({
    String? id,
    String? name,
    String? icon,
    String? color,
    bool? isIncome,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}
