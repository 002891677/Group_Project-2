import 'package:flutter/material.dart';

// Screens
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/signup_screen.dart';
import '../features/home/home_screen.dart';
import '../features/mood/mood_tracking_screen.dart';
import '../features/journal/journal_entry_screen.dart';
import '../features/journal/journal_history_screen.dart';
import '../features/analytics/insights_screen.dart';
import '../features/mindfulness/mindfulness_screen.dart';
import '../features/reminders/reminders_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String onboarding = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String moodTracking = '/mood-tracking';
  static const String journalEntry = '/journal-entry';
  static const String journalHistory = '/journal-history';
  static const String insights = '/insights';
  static const String mindfulness = '/mindfulness';
  static const String reminders = '/reminders';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case moodTracking:
        return MaterialPageRoute(builder: (_) => const MoodTrackingScreen());
      case journalEntry:
        return MaterialPageRoute(builder: (_) => const JournalEntryScreen());
      case journalHistory:
        return MaterialPageRoute(builder: (_) => const JournalHistoryScreen());
      case insights:
        return MaterialPageRoute(builder: (_) => const InsightsScreen());
      case mindfulness:
        return MaterialPageRoute(builder: (_) => const MindfulnessScreen());
      case reminders:
        return MaterialPageRoute(builder: (_) => const RemindersScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
