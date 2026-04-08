import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:expense_tracker/features/auth/domain/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryImpl implements UserRepository {
  final HiveService hiveService;

  UserRepositoryImpl({required this.hiveService});

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final box = await HiveService.getUserBox();
      if (box.isNotEmpty) {
        return box.getAt(0);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<UserEntity> signUp(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      // Check if email already exists
      final exists = await isEmailExists(email);
      if (exists) {
        throw Exception('Email already exists');
      }

      final user = UserEntity(
        id: const Uuid().v4(),
        fullName: fullName,
        email: email,
        password: password, // In production, hash this password
        createdAt: DateTime.now(),
        avatar: '👤', // Default avatar
      );

      final box = await HiveService.getUserBox();
      await box.clear(); // Clear to store only one user (current user)
      await box.add(user);

      return user;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    try {
      final box = await HiveService.getUserBox();

      // In production, you would query all users and validate
      // For now, we check if stored user matches
      if (box.isNotEmpty) {
        final user = box.getAt(0) as UserEntity;
        if (user.email == email && user.password == password) {
          return user;
        }
      }

      // If no user found or credentials don't match
      return null;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final box = await HiveService.getUserBox();
      await box.clear();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    try {
      final box = await HiveService.getUserBox();
      if (box.isNotEmpty) {
        final updatedUser = user.copyWith(updatedAt: DateTime.now());
        await box.putAt(0, updatedUser);
        return updatedUser;
      }
      throw Exception('No user found to update');
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @override
  Future<bool> isEmailExists(String email) async {
    try {
      final box = await HiveService.getUserBox();
      // In production, maintain a separate list of all registered emails
      // For now, check if current stored user has this email
      if (box.isNotEmpty) {
        final user = box.getAt(0) as UserEntity;
        return user.email == email;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to check email: $e');
    }
  }
}
