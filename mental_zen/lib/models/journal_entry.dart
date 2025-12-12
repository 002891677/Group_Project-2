class JournalEntry {
  final String id;
  final DateTime timestamp;
  final int? moodIndex; // optional
  final String text;

  JournalEntry({
    required this.id,
    required this.timestamp,
    required this.text,
    this.moodIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'moodIndex': moodIndex,
      'text': text,
    };
  }

  factory JournalEntry.fromMap(String id, Map<String, dynamic> map) {
    return JournalEntry(
      id: id,
      timestamp: DateTime.parse(map['timestamp'] as String),
      moodIndex: map['moodIndex'] as int?,
      text: map['text'] as String? ?? '',
    );
  }
}
