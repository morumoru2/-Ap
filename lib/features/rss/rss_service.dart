import 'package:dio/dio.dart';
import 'package:xml/xml.dart';
import 'package:drift/drift.dart' as drift;
import '../../../database/app_database.dart';
import '../../../core/constants/app_constants.dart';

class RssService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: AppConstants.rssTimeout,
    receiveTimeout: AppConstants.rssTimeout,
  ));

  /// YouTubeチャンネルのRSSフィードを取得し、YoutubeItemsCompanionリストに変換する
  Future<List<YoutubeItemsCompanion>> fetchYoutubeFeed(
    int oshiId,
    String channelId,
  ) async {
    try {
      final url = '${AppConstants.youtubeRssBaseUrl}$channelId';
      final response = await _dio.get(url);
      if (response.statusCode != 200) {
        throw Exception('HTTP Error: ${response.statusCode}');
      }

      final document = XmlDocument.parse(response.data.toString());
      final entries = document.findAllElements('entry');

      final List<YoutubeItemsCompanion> items = [];

      for (var entry in entries) {
        final videoId = entry.findElements('yt:videoId').firstOrNull?.innerText;
        final title = entry.findElements('title').firstOrNull?.innerText;
        final publishedStr = entry.findElements('published').firstOrNull?.innerText;
        
        final mediaGroup = entry.findElements('media:group').firstOrNull;
        final thumbnailNode = mediaGroup?.findElements('media:thumbnail').firstOrNull;
        final thumbnailUrl = thumbnailNode?.getAttribute('url');

        if (videoId != null && title != null && publishedStr != null) {
          final publishedAt = DateTime.tryParse(publishedStr) ?? DateTime.now();

          items.add(
            YoutubeItemsCompanion(
              oshiId: drift.Value(oshiId),
              videoId: drift.Value(videoId),
              title: drift.Value(title),
              publishedAt: drift.Value(publishedAt),
              thumbnailUrl: drift.Value(thumbnailUrl),
              isRead: const drift.Value(false),
              isFavorite: const drift.Value(false),
            ),
          );
        }
      }

      return items;
    } catch (e) {
      print('Error fetching RSS feed for channel $channelId: $e');
      rethrow;
    }
  }

  /// ライブ配信っぽいタイトルか判定
  static bool isLiveStream(String title) {
    final lower = title.toLowerCase();
    return lower.contains('live') ||
        lower.contains('ライブ') ||
        lower.contains('配信中') ||
        lower.contains('【live') ||
        lower.contains('[live');
  }
}
