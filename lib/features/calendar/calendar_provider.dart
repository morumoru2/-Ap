import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../database/app_database.dart';
import '../../core/services/notification_scheduler.dart';

final schedulesStreamProvider = StreamProvider<List<Schedule>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllSchedules();
});

final scheduleOperationsProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return ScheduleOperations(db);
});

class ScheduleOperations {
  final AppDatabase _db;
  ScheduleOperations(this._db);

  Future<int> addSchedule(SchedulesCompanion schedule) async {
    final id = await _db.insertSchedule(schedule);
    await NotificationScheduler.syncAll(_db);
    return id;
  }

  Future<bool> updateSchedule(SchedulesCompanion schedule) async {
    final ok = await _db.updateSchedule(schedule);
    await NotificationScheduler.syncAll(_db);
    return ok;
  }

  Future<void> deleteSchedule(int id) async {
    await _db.deleteSchedule(id);
    await NotificationScheduler.syncAll(_db);
  }
}
