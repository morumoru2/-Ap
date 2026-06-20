import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';
import 'database/app_database.dart';
import 'core/services/app_prefs.dart';
import 'core/services/background_sync_service.dart';
import 'core/services/icloud_sync_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/notification_scheduler.dart';
import 'core/services/widget_update_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPrefs.init();
  await initializeDateFormatting('ja_JP');
  await NotificationService.instance.init();
  await WidgetUpdateService.init();

  // iCloud から最新 DB を取得してから起動
  await ICloudSyncService.pullOnLaunch();

  final container = ProviderContainer();
  final db = container.read(databaseProvider);

  await NotificationScheduler.syncAll(db);
  await WidgetUpdateService.updateFromDatabase(db);

  await BackgroundSyncService.init();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
