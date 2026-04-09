import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:expense_tracker/features/auth/presentation/provider/auth_provider.dart';
import 'package:expense_tracker/features/home/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (isLoggedIn) {
        if (isLoggedIn) {
          print("user is already loged in");
          return const MainScreen();
        } else {
          print("don't loged in do signin");
          return const SignInScreen();
        }
      },
      loading: () => const _SplashScreen(),
      error: (error, stackTrace) {
        // on error , show the signin screen
        print("error on auth check : $error");
        return const SignInScreen();
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.darkBg, AppTheme.darkCard.withOpacity(0.8)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.gradientStart, AppTheme.gradientEnd],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.gradientStart.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('💰', style: TextStyle(fontSize: 50)),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Expense Tracker',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your Financial Journey Starts Here',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.darkTextSecondary,
                ),
              ),
              const SizedBox(height: 48),

              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.gradientStart,
                  ),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
