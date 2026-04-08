import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/auth/presentation/pages/auth_gate.dart';
import 'package:expense_tracker/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:expense_tracker/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:expense_tracker/features/home/presentation/pages/main_screen.dart';
import 'package:expense_tracker/features/profile/domin/states/theme_provider.dart';
import 'package:expense_tracker/core/storage/hive_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: AuthGate(),
      routes: {
        '/home': (context) => const MainScreen(),
        '/sign-in': (context) => const SignInScreen(),
        '/sign-up': (context) => const SignUpScreen(),
      },
    );
  }
}
