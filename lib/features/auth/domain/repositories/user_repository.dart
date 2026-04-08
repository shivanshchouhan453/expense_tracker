import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity> signUp(String fullName, String email, String password);
  Future<UserEntity?> signIn(String email, String password);
  Future<void> signOut();
  Future<UserEntity> updateUser(UserEntity user);
  Future<bool> isEmailExists(String email);
}
