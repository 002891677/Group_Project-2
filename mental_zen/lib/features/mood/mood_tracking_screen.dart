import 'package:flutter/material.dart';
import 'package:mental_zen/services/mood_service.dart';

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
                    setState(() => _selectedMood = index);
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
                  : () async {
                      await MoodService.instance.saveMood(_selectedMood!);
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Mood saved (temporary local store).'),
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

class MoodService {
  static final MoodService _instance = MoodService._internal();

  MoodService._internal();

  static MoodService get instance => _instance;

  Future<void> saveMood(int mood) async {
    // TODO: Implement mood saving logic (e.g., to local database or API)
    print('Mood saved: $mood');
  }
}
