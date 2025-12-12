import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_zen/services/auth_service.dart';
import 'package:mental_zen/models/mood_entry.dart';

class MoodService {
  MoodService._internal();
  static final MoodService instance = MoodService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _collection(String uid) {
    return _db.collection('users').doc(uid).collection('moods');
  }

  Future<void> saveMood(int moodIndex) async {
    final user = AuthService.instance.currentUser;
    if (user == null) return;

    await _collection(user.uid).add({
      'timestamp': DateTime.now().toIso8601String(),
      'moodIndex': moodIndex,
    });
  }

  Future<List<MoodEntry>> fetchAll() async {
    final user = AuthService.instance.currentUser;
    if (user == null) return [];

    final snapshot = await _collection(
      user.uid,
    ).orderBy('timestamp', descending: true).get();

    return snapshot.docs
        .map((doc) => MoodEntry.fromMap(doc.id, doc.data()))
        .toList();
  }
}
