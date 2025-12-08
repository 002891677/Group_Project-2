import 'package:flutter/material.dart';

class MindfulnessScreen extends StatelessWidget {
  const MindfulnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real mindfulness content
    final exercises = [
      '1-minute breathing exercise',
      'Body scan relaxation',
      'Gratitude reflection',
      'Positive affirmations',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mindfulness')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(exercises[index]),
              subtitle: const Text('Tap to practice (static for now).'),
            ),
          );
        },
      ),
    );
  }
}
