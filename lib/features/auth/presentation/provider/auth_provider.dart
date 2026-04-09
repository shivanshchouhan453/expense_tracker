import 'package:expense_tracker/features/auth/domain/entities/user_entity.dart';
import 'package:expense_tracker/features/auth/presentation/provider/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = StreamProvider<UserEntity?>((ref) async* {
  final userRepository = ref.watch(userRepositoryProvider);
  while (true) {
    final user = await userRepository.getCurrentUser();
    yield user;
    await Future.delayed(const Duration(seconds: 1));
  }
});

final currentUserAsyncProvider = FutureProvider<UserEntity?>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getCurrentUser();
});

final signUpProvider =
    FutureProvider.family<
      UserEntity,
      ({String fullName, String email, String password})
    >((ref, params) async {
      final userRepository = ref.watch(userRepositoryProvider);
      return userRepository.signUp(
        params.fullName,
        params.email,
        params.password,
      );
    });

final signInProvider =
    FutureProvider.family<UserEntity?, ({String email, String password})>((
      ref,
      params,
    ) async {
      final userRepository = ref.watch(userRepositoryProvider);
      final user = await userRepository.signIn(params.email, params.password);
      if (user != null) {
        // when not null invalidate the provider
        ref.invalidate(currentUserAsyncProvider);
      }
      return user;
    });

final signOutProvider = FutureProvider<void>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  await userRepository.signOut();
  ref.invalidate(currentUserAsyncProvider);
});

final updateUserProvider = FutureProvider.family<UserEntity, UserEntity>((
  ref,
  user,
) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final updatedUser = await userRepository.updateUser(user);
  ref.invalidate(currentUserAsyncProvider);
  return updatedUser;
});

final authStateProvider = StreamProvider<bool>((ref) async* {
  final userRepository = ref.watch(userRepositoryProvider);
  while (true) {
    final user = await userRepository.getCurrentUser();
    yield user != null;
    await Future.delayed(const Duration(milliseconds: 500));
  }
});

final checkEmailProvider = FutureProvider.family<bool, String>((
  ref,
  email,
) async {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.isEmailExists(email);
});
