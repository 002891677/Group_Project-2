import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real analytics later
    return Scaffold(
      appBar: AppBar(title: const Text('Insights & Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('This is where mood charts and streaks will appear.'),
            SizedBox(height: 16),
            Text('- Average mood'),
            Text('- Mood trend chart'),
            Text('- Journaling streak'),
          ],
        ),
      ),
    );
  }
}
