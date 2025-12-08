import 'package:flutter/material.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  TimeOfDay _time = const TimeOfDay(hour: 20, minute: 0);
  bool _enabled = false;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() {
        _time = picked;
      });
    }
  }

  void _saveSettings() {
    // TODO: Save reminder settings + schedule notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _enabled
              ? 'Reminder set for ${_time.format(context)} (placeholder).'
              : 'Reminders turned off.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wellness Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Enable daily reminder'),
              value: _enabled,
              onChanged: (value) {
                setState(() {
                  _enabled = value;
                });
              },
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Reminder time'),
              subtitle: Text(_time.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _enabled ? _pickTime : null,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveSettings,
              child: const Text('Save settings'),
            ),
          ],
        ),
      ),
    );
  }
}
