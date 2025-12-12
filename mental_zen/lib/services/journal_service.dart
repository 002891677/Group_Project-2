import 'package:uuid/uuid.dart';
import '../models/journal_entry.dart';

class JournalService {
  static final JournalService instance = JournalService._internal();
  JournalService._internal();

  final _uuid = const Uuid();
  final List<JournalEntry> _entries = [];

  List<JournalEntry> get entries =>
      List.unmodifiable(_entries..sort((a, b) => b.timestamp.compareTo(a.timestamp)));

  Future<void> saveEntry(String text, {int? moodIndex}) async {
    // TODO(Sai): Replace with Firestore write
    final entry = JournalEntry(
      id: _uuid.v4(),
      timestamp: DateTime.now(),
      text: text,
      moodIndex: moodIndex,
    );
    _entries.add(entry);
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
