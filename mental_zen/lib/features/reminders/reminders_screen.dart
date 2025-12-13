import 'package:flutter/material.dart';
import 'package:mental_zen/services/reminder_service.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool _enabled = false;
  TimeOfDay _time = const TimeOfDay(hour: 20, minute: 0);

  Future<void> _saveReminder() async {
    final timeString =
        '${_time.hour.toString().padLeft(2, '0')}:${_time.minute.toString().padLeft(2, '0')}';

    await ReminderService.instance.saveReminder(_enabled, timeString);

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reminder saved')));
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() => _time = picked);
    }
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
              title: const Text('Enable Daily Reminder'),
              value: _enabled,
              onChanged: (val) => setState(() => _enabled = val),
            ),
            ListTile(
              title: const Text('Reminder Time'),
              subtitle: Text(_time.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            const Spacer(),
            ElevatedButton(onPressed: _saveReminder, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
