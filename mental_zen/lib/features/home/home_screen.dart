import 'package:flutter/material.dart';
import '../../core/app_routes.dart';
import '../../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Zen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.instance.signOut();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile(context, 'Mood Tracking', AppRoutes.moodTracking, surface),
          _tile(context, 'Journal Entry', AppRoutes.journalEntry, surface),
          _tile(context, 'Journal History', AppRoutes.journalHistory, surface),
          _tile(context, 'Mindfulness', AppRoutes.mindfulness, surface),
          _tile(context, 'Insights', AppRoutes.insights, surface),
          _tile(context, 'Reminders', AppRoutes.reminders, surface),
        ],
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    String title,
    String route,
    Color surface,
  ) {
    return Card(
      color: surface.withValues(alpha: 0.3),
      child: ListTile(
        title: Text(title),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
