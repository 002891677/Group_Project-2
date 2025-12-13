import 'package:flutter/material.dart';
import 'package:mental_zen/services/journal_service.dart';
import 'package:mental_zen/models/journal_entry.dart';

class JournalHistoryScreen extends StatelessWidget {
  const JournalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journal History')),
      body: FutureBuilder<List<JournalEntry>>(
        future: JournalService.instance.fetchAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No journal entries yet.'));
          }

          final entries = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(entry.text),
                  subtitle: Text(entry.timestamp.toLocal().toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
