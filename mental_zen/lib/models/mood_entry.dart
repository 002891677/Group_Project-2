class MoodEntry {
  final String id;
  final DateTime timestamp;
  final int moodIndex;

  MoodEntry({
    required this.id,
    required this.timestamp,
    required this.moodIndex,
  });

  factory MoodEntry.fromMap(String id, Map<String, dynamic> data) {
    return MoodEntry(
      id: id,
      timestamp: DateTime.parse(data['timestamp']),
      moodIndex: data['moodIndex'],
    );
  }
}
