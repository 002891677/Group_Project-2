class MoodEntry {
  final String id;
  final DateTime timestamp;
  // 0–4 index for 😞 to 🤩
  final int moodIndex;

  MoodEntry({
    required this.id,
    required this.timestamp,
    required this.moodIndex,
  });

  Map<String, dynamic> toMap() {
    return {'timestamp': timestamp.toIso8601String(), 'moodIndex': moodIndex};
  }

  factory MoodEntry.fromMap(String id, Map<String, dynamic> map) {
    return MoodEntry(
      id: id,
      timestamp: DateTime.parse(map['timestamp'] as String),
      moodIndex: map['moodIndex'] as int,
    );
  }
}
