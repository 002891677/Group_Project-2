import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class MoodService {
  MoodService._internal();
  static final MoodService instance = MoodService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _col(String uid) {
    return _db.collection('users').doc(uid).collection('moodEntries');
  }

  Future<void> saveMood(int moodIndex) async {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      throw Exception('Not logged in');
    }

    await _col(
      user.uid,
    ).add({'timestamp': FieldValue.serverTimestamp(), 'moodIndex': moodIndex});
  }

  /// Latest mood entries (descending). Used by Insights screen.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamRecent({int limit = 50}) {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _col(
      user.uid,
    ).orderBy('timestamp', descending: true).limit(limit).snapshots();
  }
}
