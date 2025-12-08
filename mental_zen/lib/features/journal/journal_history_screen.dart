import 'package:flutter/material.dart';

class JournalHistoryScreen extends StatelessWidget {
  const JournalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with Firestore data
    final dummyEntries = List.generate(
      5,
      (index) => 'Journal entry #${index + 1}',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Journal History')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyEntries.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            tileColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
            title: Text(dummyEntries[index]),
            subtitle: const Text('Preview of your thoughts...'),
          );
        },
      ),
    );
  }
}
