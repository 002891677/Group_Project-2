import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mental_zen/core/app_theme.dart';
import 'package:mental_zen/services/auth_service.dart';
import 'package:mental_zen/features/auth/login_screen.dart';
import 'package:mental_zen/features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MentalZenApp());
}

class MentalZenApp extends StatelessWidget {
  const MentalZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Zen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService.instance.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return snapshot.hasData ? const HomeScreen() : const LoginScreen();
      },
    );
  }
}
