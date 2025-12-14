import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/mood_service.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  static const List<String> _emojis = ['😞', '😕', '😐', '🙂', '😁'];
  static const List<String> _labels = [
    'Very Low',
    'Low',
    'Okay',
    'Good',
    'Great',
  ];

  String _formatDate(DateTime d) {
    final mm = d.month.toString().padLeft(2, '0');
    final dd = d.day.toString().padLeft(2, '0');
    final hh = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0');
    return '$mm/$dd ${hh}:${min}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: MoodService.instance.streamRecent(limit: 60),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No mood data yet. Save a mood to see insights.'),
            );
          }

          final docs = snapshot.data!.docs;

          // Convert docs -> (date, moodIndex)
          final entries = <({DateTime date, int mood})>[];

          for (final d in docs) {
            final data = d.data();
            final mood = (data['moodIndex'] ?? 2) as int;

            final ts = data['timestamp'];
            DateTime date;

            if (ts is Timestamp) {
              date = ts.toDate();
            } else {
              // fallback if timestamp is missing (very rare)
              date = DateTime.now();
            }

            if (mood >= 0 && mood <= 4) {
              entries.add((date: date, mood: mood));
            }
          }

          if (entries.isEmpty) {
            return const Center(child: Text('No valid mood entries found.'));
          }

          // --- Analytics computations ---
          final avg =
              entries.map((e) => e.mood).reduce((a, b) => a + b) /
              entries.length;
          final avgRounded = avg.toStringAsFixed(2);

          // Count distribution
          final counts = List<int>.filled(5, 0);
          for (final e in entries) {
            counts[e.mood] += 1;
          }

          // Last 7 days average
          final now = DateTime.now();
          final weekAgo = now.subtract(const Duration(days: 7));
          final weekEntries = entries
              .where((e) => e.date.isAfter(weekAgo))
              .toList();
          final weekAvg = weekEntries.isEmpty
              ? null
              : (weekEntries.map((e) => e.mood).reduce((a, b) => a + b) /
                    weekEntries.length);

          final surface = Theme.of(context).colorScheme.surface;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: surface.withValues(alpha: 0.25),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Total entries: ${entries.length}'),
                      Text('Overall average mood index: $avgRounded (0..4)'),
                      Text(
                        weekAvg == null
                            ? 'Last 7 days average: N/A'
                            : 'Last 7 days average: ${weekAvg.toStringAsFixed(2)} (0..4)',
                      ),
                      const SizedBox(height: 12),

                      // Mood distribution bars (simple, no chart lib)
                      const Text(
                        'Mood distribution',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: List.generate(5, (i) {
                          final total = entries.length;
                          final pct = total == 0 ? 0.0 : counts[i] / total;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(width: 30, child: Text(_emojis[i])),
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    _labels[i],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: pct,
                                    minHeight: 10,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 40,
                                  child: Text('${counts[i]}'),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Recent moods',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),

              // Recent list
              ...entries.take(15).map((e) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      _emojis[e.mood],
                      style: const TextStyle(fontSize: 28),
                    ),
                    title: Text(_labels[e.mood]),
                    subtitle: Text(_formatDate(e.date)),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
