import 'package:flutter/material.dart';
import '../../services/mood_service.dart';

class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  State<MoodTrackingScreen> createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen> {
  int _selected = 3;

  Future<void> _saveMood() async {
    await MoodService.instance.saveMood(_selected);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Mood saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('How are you feeling today?'),
            Slider(
              min: 1,
              max: 5,
              divisions: 4,
              value: _selected.toDouble(),
              label: _selected.toString(),
              onChanged: (v) {
                setState(() {
                  _selected = v.round();
                });
              },
            ),
            ElevatedButton(onPressed: _saveMood, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
