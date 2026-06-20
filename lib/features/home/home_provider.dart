import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../database/app_database.dart';
import '../oshi/oshi_provider.dart';
import '../rss/rss_provider.dart';

/// お気に入りの推しだけを抽出する Provider
final favoriteOshiProvider = Provider<AsyncValue<List<Oshi>>>((ref) {
  final oshiListAsync = ref.watch(oshiListProvider);
  return oshiListAsync.whenData((list) => list.where((o) => o.isFavorite).toList());
});

/// 最新の動画 (5件) を取得する Provider
final recentVideosProvider = Provider<AsyncValue<List<YoutubeItem>>>((ref) {
  final youtubeItemsAsync = ref.watch(youtubeItemsStreamProvider);
  return youtubeItemsAsync.whenData((items) => items.take(5).toList());
});

/// 未読の動画件数を取得する StreamProvider
final unreadVideosCountProvider = StreamProvider<int>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllYoutubeItems().map((items) => items.where((i) => !i.isRead).length);
});
