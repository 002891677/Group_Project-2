import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';

class ReminderService {
  ReminderService._internal();
  static final ReminderService instance = ReminderService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentReference<Map<String, dynamic>> _doc(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('settings')
        .doc('reminder');
  }

  // ✅ This method matches what your screen calls
  Future<void> saveReminder(bool enabled, String timeHHmm) async {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    await _doc(user.uid).set({
      'enabled': enabled,
      'time': timeHHmm,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamReminder() {
    final user = AuthService.instance.currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    return _doc(user.uid).snapshots();
  }
}
