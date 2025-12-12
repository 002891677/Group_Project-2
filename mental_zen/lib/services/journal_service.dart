import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_zen/services/auth_service.dart';
import 'package:mental_zen/models/journal_entry.dart';

class JournalService {
  JournalService._internal();
  static final JournalService instance = JournalService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return _db.collection('users').doc(uid).collection('journals');
  }

  Future<void> saveEntry(String text, {int? moodIndex}) async {
    final user = AuthService.instance.currentUser;
    if (user == null) return;

    await _collection(user.uid).add({
      'timestamp': DateTime.now().toIso8601String(),
      'text': text,
      'moodIndex': moodIndex,
    });
  }

  Future<List<JournalEntry>> fetchAll() async {
    final user = AuthService.instance.currentUser;
    if (user == null) return [];

    final snapshot = await _collection(
      user.uid,
    ).orderBy('timestamp', descending: true).get();

    return snapshot.docs
        .map((doc) => JournalEntry.fromMap(doc.id, doc.data()))
        .toList();
  }
}
