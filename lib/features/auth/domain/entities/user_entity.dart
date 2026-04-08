import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 2)
class UserEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? updatedAt;

  @HiveField(6)
  final String? avatar;

  @HiveField(7)
  final String? phone;

  @HiveField(8)
  final String? bio;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.createdAt,
    this.updatedAt,
    this.avatar,
    this.phone,
    this.bio,
  });

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avatar,
    String? phone,
    String? bio,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }

  @override
  String toString() =>
      'UserEntity(id: $id, fullName: $fullName, email: $email, createdAt: $createdAt)';
}
