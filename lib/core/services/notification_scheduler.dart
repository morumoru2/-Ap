import '../../database/app_database.dart';
import '../utils/date_utils.dart';
import 'notification_service.dart';

class NotificationScheduler {
  NotificationScheduler._();

  static Future<void> syncAll(AppDatabase db) async {
    await _syncBirthdays(db);
    await _syncSchedules(db);
  }

  static Future<void> _syncBirthdays(AppDatabase db) async {
    final oshis = await db.getAllOshis();
    for (final oshi in oshis) {
      final birthday = AppDateUtils.tryParse(oshi.birthday);
      if (birthday == null) continue;

      final now = DateTime.now();
      var next = DateTime(now.year, birthday.month, birthday.day, 9);
      if (next.isBefore(now)) {
        next = DateTime(now.year + 1, birthday.month, birthday.day, 9);
      }

      await NotificationService.instance.scheduleEventNotification(
        id: 10000 + oshi.id,
        title: '${oshi.name} の誕生日',
        body: '今日は ${oshi.name} の誕生日です！',
        scheduledDate: next,
      );
    }
  }

  static Future<void> _syncSchedules(AppDatabase db) async {
    final schedules = await db.getAllSchedules();
    for (final schedule in schedules) {
      if (!schedule.notificationEnabled) {
        await NotificationService.instance.cancelNotification(20000 + schedule.id);
        continue;
      }

      final notifyAt = schedule.eventDate.subtract(const Duration(hours: 1));
      if (notifyAt.isBefore(DateTime.now())) continue;

      await NotificationService.instance.scheduleEventNotification(
        id: 20000 + schedule.id,
        title: 'まもなく: ${schedule.title}',
        body: '1時間後に予定があります',
        scheduledDate: notifyAt,
      );
    }
  }
}
