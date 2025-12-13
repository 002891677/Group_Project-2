import 'package:flutter/material.dart';
import '../../services/reminder_service.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool _enabled = false;
  String _time = '09:00';

  Future<void> _save() async {
    await ReminderService.instance.saveReminder(_enabled, _time);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reminder saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Enable daily reminder'),
              value: _enabled,
              onChanged: (v) {
                setState(() {
                  _enabled = v;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Reminder time (HH:mm)',
              ),
              controller: TextEditingController(text: _time),
              onChanged: (v) {
                _time = v;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
