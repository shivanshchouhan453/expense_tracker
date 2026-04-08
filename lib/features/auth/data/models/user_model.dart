import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? avatar;
  final String? phone;
  final String? bio;

  UserModel({
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

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      fullName: fullName,
      email: email,
      password: password,
      createdAt: createdAt,
      updatedAt: updatedAt,
      avatar: avatar,
      phone: phone,
      bio: bio,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      avatar: entity.avatar,
      phone: entity.phone,
      bio: entity.bio,
    );
  }

  UserModel copyWith({
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
    return UserModel(
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
}
