class JournalEntry {
  final String id;
  final DateTime timestamp;
  final String text;
  final int? moodIndex;

  JournalEntry({
    required this.id,
    required this.timestamp,
    required this.text,
    this.moodIndex,
  });

  factory JournalEntry.fromMap(String id, Map<String, dynamic> data) {
    return JournalEntry(
      id: id,
      timestamp: DateTime.parse(data['timestamp']),
      text: data['text'],
      moodIndex: data['moodIndex'],
    );
  }
}
