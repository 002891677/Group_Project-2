import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_zen/services/auth_service.dart';

class ReminderService {
  ReminderService._internal();
  static final ReminderService instance = ReminderService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveReminder(bool enabled, String time) async {
    final user = AuthService.instance.currentUser;
    if (user == null) return;

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('settings')
        .doc('reminder')
        .set({'enabled': enabled, 'time': time});
  }
}
