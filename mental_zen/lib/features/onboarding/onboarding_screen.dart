import 'package:flutter/material.dart';
import '../../core/app_routes.dart';
import '../../core/widgets/primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text('Mental Zen', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text(
                'A gentle space to track your mood,\njournal your thoughts, and build calm habits.',
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: 'I already have an account',
                filled: false,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
