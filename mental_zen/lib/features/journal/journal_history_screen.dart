import 'package:flutter/material.dart';

import '../../services/journal_service.dart';

class JournalHistoryScreen extends StatelessWidget {
  const JournalHistoryScreen({super.key});

  String _formatDate(DateTime dt) {
    // simple date-time formatting; later you can use intl package
    return dt.toLocal().toString().split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    final entries = JournalService.instance.entries;

    return Scaffold(
      appBar: AppBar(title: const Text('Journal History')),
      body: entries.isEmpty
          ? const Center(child: Text('No entries yet. Start journaling!'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final e = entries[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Theme.of(
                    context,
                  ).colorScheme.surface.withOpacity(0.3),
                  title: Text(
                    e.text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(_formatDate(e.timestamp)),
                );
              },
            ),
    );
  }
}
