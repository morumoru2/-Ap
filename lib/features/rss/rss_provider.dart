import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../database/app_database.dart';
import '../../core/services/notification_service.dart';
import '../../core/services/widget_update_service.dart';
import 'rss_service.dart';

final rssServiceProvider = Provider<RssService>((ref) => RssService());

final youtubeItemsStreamProvider = StreamProvider<List<YoutubeItem>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllYoutubeItems();
});

final rssSyncProvider = StateNotifierProvider<RssSyncNotifier, AsyncValue<void>>((ref) {
  final db = ref.watch(databaseProvider);
  final service = ref.watch(rssServiceProvider);
  return RssSyncNotifier(db, service);
});

class RssSyncNotifier extends StateNotifier<AsyncValue<void>> {
  final AppDatabase _db;
  final RssService _service;

  RssSyncNotifier(this._db, this._service) : super(const AsyncValue.data(null));

  Future<void> syncAllFeeds({bool notify = true}) async {
    state = const AsyncValue.loading();
    try {
      final oshis = await _db.getAllOshis();
      for (var oshi in oshis) {
        if (oshi.youtubeChannelId != null && oshi.youtubeChannelId!.isNotEmpty) {
          try {
            final items = await _service.fetchYoutubeFeed(
              oshi.id,
              oshi.youtubeChannelId!,
            );
            for (var item in items) {
              final isNew = await _db.insertYoutubeItem(item);
              if (notify && isNew) {
                final title = item.title.value;
                final isLive = RssService.isLiveStream(title);
                final notifId = item.videoId.value.hashCode;
                if (isLive) {
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
          } catch (e) {
            print('Failed to sync feed for oshi ${oshi.name}: $e');
          }
        }
      }
      await WidgetUpdateService.updateFromDatabase(_db);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> syncSingleFeed(int oshiId, String channelId) async {
    state = const AsyncValue.loading();
    try {
      final items = await _service.fetchYoutubeFeed(oshiId, channelId);
      for (var item in items) {
        await _db.insertYoutubeItem(item);
      }
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> markAsRead(int id) async {
    await _db.markYoutubeItemAsRead(id);
  }

  Future<void> toggleFavorite(int id, bool isFavorite) async {
    await _db.toggleYoutubeItemFavorite(id, isFavorite);
  }
}
