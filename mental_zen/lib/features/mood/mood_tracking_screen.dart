import 'package:flutter/material.dart';
import '../../services/mood_service.dart';

class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  State<MoodTrackingScreen> createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen> {
  // 0..4
  int _selectedMoodIndex = 2;

  static const List<String> _emojis = ['😞', '😕', '😐', '🙂', '😁'];
  static const List<String> _labels = [
    'Very Low',
    'Low',
    'Okay',
    'Good',
    'Great',
  ];

  Future<void> _saveMood() async {
    await MoodService.instance.saveMood(_selectedMoodIndex);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood saved: ${_labels[_selectedMoodIndex]}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedEmoji = _emojis[_selectedMoodIndex];
    final selectedLabel = _labels[_selectedMoodIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracking')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Big selected emoji preview
            Text(
              selectedEmoji,
              style: const TextStyle(fontSize: 64),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              selectedLabel,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Emoji scale row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_emojis.length, (index) {
                final isSelected = _selectedMoodIndex == index;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        setState(() {
                          _selectedMoodIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.transparent,
                          ),
                          color: isSelected
                              ? Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.12)
                              : Theme.of(
                                  context,
                                ).colorScheme.surface.withValues(alpha: 0.25),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _emojis[index],
                              style: TextStyle(fontSize: isSelected ? 34 : 30),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _labels[index],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 22),

            // Optional: Slider too (keeps accessibility / easier selection)
            Slider(
              min: 0,
              max: 4,
              divisions: 4,
              value: _selectedMoodIndex.toDouble(),
              label: selectedLabel,
              onChanged: (v) {
                setState(() {
                  _selectedMoodIndex = v.round();
                });
              },
            ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: _saveMood,
              icon: const Icon(Icons.save),
              label: const Text('Save Mood'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
