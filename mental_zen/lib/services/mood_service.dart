// lib/services/mood_service.dart
import 'package:uuid/uuid.dart';

import '../models/mood_entry.dart';

class MoodService {
  // Singleton pattern: MoodService.instance
  MoodService._internal();
  static final MoodService instance = MoodService._internal();

  final _uuid = const Uuid();
  final List<MoodEntry> _entries = [];

  List<MoodEntry> get entries => List.unmodifiable(_entries);

  Future<void> saveMood(int moodIndex) async {
    // For now this just stores in memory; later you can swap in Firestore.
    final entry = MoodEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      moodIndex: moodIndex,
    );
    _entries.add(entry);

    await Future.delayed(const Duration(milliseconds: 200));
  }
}
