import 'package:flutter/material.dart';

class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  State<MoodTrackingScreen> createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen> {
  int? _selectedMood;

  @override
  Widget build(BuildContext context) {
    final moods = ['😞', '😐', '🙂', '😊', '🤩'];

    return Scaffold(
      appBar: AppBar(title: const Text('Daily Mood')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('How are you feeling today?'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(moods.length, (index) {
                final isSelected = _selectedMood == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedMood = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      moods[index],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedMood == null
                  ? null
                  : () {
                      // TODO: Save mood to Firestore later
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mood saved (locally for now)'),
                        ),
                      );
                    },
              child: const Text('Save mood'),
            ),
          ],
        ),
      ),
    );
  }
}
