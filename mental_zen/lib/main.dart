import 'package:flutter/material.dart';

import 'core/app_routes.dart';
import 'services/auth_service.dart';
import 'features/home/home_screen.dart';
import 'features/auth/login_screen.dart';

void main() {
  runApp(const MentalZenApp());
}

class MentalZenApp extends StatelessWidget {
  const MentalZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Zen',
      debugShowCheckedModeBanner: false,

      // ✅ IMPORTANT: keeps routes working for /signup, /login, etc.
      onGenerateRoute: AppRoutes.generateRoute,

      // Use AuthGate so app decides whether to show Login or Home
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // For now: uses stub AuthService. Later replace with Firebase auth state.
    return AuthService.instance.isLoggedIn
        ? const HomeScreen()
        : const LoginScreen();
  }
}
