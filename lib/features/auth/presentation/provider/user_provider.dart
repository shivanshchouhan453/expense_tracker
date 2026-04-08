import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:expense_tracker/features/auth/data/repositories/user_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(hiveService: HiveService());
});
