import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../database/app_database.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/cached_thumbnail.dart';
import '../home_provider.dart';
import '../../oshi/oshi_provider.dart';
import '../../rss/rss_provider.dart';

class RecentVideosCard extends ConsumerWidget {
  const RecentVideosCard({super.key});

  Future<void> _openVideo(BuildContext context, WidgetRef ref, YoutubeItem item) async {
    final url = 'https://www.youtube.com/watch?v=${item.videoId}';
    await ref.read(rssSyncProvider.notifier).markAsRead(item.id);

    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Error handling
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentVideosAsync = ref.watch(recentVideosProvider);
    final oshiListAsync = ref.watch(oshiListProvider);

    return recentVideosAsync.when(
      data: (items) {
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '最新動画',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                String oshiName = '';
                Color oshiColor = AppColors.primaryPink;
                oshiListAsync.whenData((list) {
                  final oshi = list.firstWhere((o) => o.id == item.oshiId, orElse: () => list.first);
                  oshiName = oshi.name;
                  if (oshi.color != null) {
                    oshiColor = ColorUtils.fromHex(oshi.color!);
                  }
                });

                return GlassCard(
                  onTap: () => _openVideo(context, ref, item),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  borderColor: item.isRead ? AppColors.glassBorder : oshiColor.withValues(alpha: 0.3),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CachedThumbnail(
                          url: item.thumbnailUrl,
                          width: 80,
                          height: 45,
                          borderRadius: 6,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  oshiName,
                                  style: TextStyle(fontSize: 10, color: oshiColor, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  AppDateUtils.relativeTime(item.publishedAt),
                                  style: const TextStyle(fontSize: 10, color: Colors.white38),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
