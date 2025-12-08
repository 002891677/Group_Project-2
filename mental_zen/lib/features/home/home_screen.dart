import 'package:flutter/material.dart';
import '../../core/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = <_HomeTile>[
      _HomeTile('Daily Mood', AppRoutes.moodTracking),
      _HomeTile('Write Journal', AppRoutes.journalEntry),
      _HomeTile('Journal History', AppRoutes.journalHistory),
      _HomeTile('Insights & Analytics', AppRoutes.insights),
      _HomeTile('Mindfulness', AppRoutes.mindfulness),
      _HomeTile('Wellness Reminders', AppRoutes.reminders),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mental Zen')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tiles.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final tile = tiles[index];
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
            title: Text(tile.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, tile.route),
          );
        },
      ),
    );
  }
}

class _HomeTile {
  final String title;
  final String route;

  _HomeTile(this.title, this.route);
}
