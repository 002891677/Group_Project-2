class ReminderService {
  static final ReminderService instance = ReminderService._internal();
  ReminderService._internal();

  bool enabled = false;
  String timeString = '20:00';

  Future<void> updateReminder({
    required bool isEnabled,
    required String time,
  }) async {
    // TODO(Sai): Replace with Firestore + flutter_local_notifications
    enabled = isEnabled;
    timeString = time;
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
