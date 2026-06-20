import 'package:workmanager/workmanager.dart';
import '../../database/app_database.dart';
import '../../features/rss/rss_service.dart';
import '../services/notification_service.dart';
import '../services/widget_update_service.dart';
import 'database_path_resolver.dart';
import 'icloud_service.dart';

const rssBackgroundTaskName = 'oshiMemoRssSync';
const rssBackgroundUniqueName = 'com.oshimemo.rss.sync';

class BackgroundSyncService {
  BackgroundSyncService._();

  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    await Workmanager().registerPeriodicTask(
      rssBackgroundUniqueName,
      rssBackgroundTaskName,
      frequency: const Duration(hours: 6),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task != rssBackgroundTaskName) return false;

    try {
      await NotificationService.instance.init();

      final dbPath = await DatabasePathResolver.resolveDatabasePath();
      final db = AppDatabase.atPath(dbPath);
      final service = RssService();
      final oshis = await db.getAllOshis();

      for (final oshi in oshis) {
        final channelId = oshi.youtubeChannelId;
        if (channelId == null || channelId.isEmpty) continue;
        try {
          final items = await service.fetchYoutubeFeed(oshi.id, channelId);
          for (final item in items) {
            final isNew = await db.insertYoutubeItem(item);
            if (isNew) {
              final title = item.title.value;
              final notifId = item.videoId.value.hashCode;
              if (RssService.isLiveStream(title)) {
                await NotificationService.instance.showLiveNotification(
                  oshiName: oshi.name,
                  title: title,
                  id: notifId,
                );
              } else {
                await NotificationService.instance.showNewVideoNotification(
                  oshiName: oshi.name,
                  title: title,
                  id: notifId,
                );
              }
            }
          }
        } catch (_) {}
      }

      await WidgetUpdateService.updateFromDatabase(db);

      final localPath = await DatabasePathResolver.localBackupPath();
      await ICloudService.pushDatabase(localPath);

      await db.close();
      return true;
    } catch (_) {
      return false;
    }
  });
}
