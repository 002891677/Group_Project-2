import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class JournalService {
  JournalService._internal();
  static final JournalService instance = JournalService._internal();

  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _db.collection('users').doc(uid).collection('journalEntries');

  Future<void> saveEntry(String text, {int? moodIndex}) async {
    final user = AuthService.instance.currentUser;
    if (user == null) throw Exception('Not logged in');

    await _col(user.uid).add({
      'timestamp': FieldValue.serverTimestamp(),
      'text': text,
      'moodIndex': moodIndex,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamAll() {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _col(user.uid).orderBy('timestamp', descending: true).snapshots();
  }
}
