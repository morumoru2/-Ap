import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../database/app_database.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/cached_thumbnail.dart';
import '../rss_provider.dart';
import '../../oshi/oshi_provider.dart';

class VideoCard extends ConsumerWidget {
  final YoutubeItem item;

  const VideoCard({super.key, required this.item});

  Future<void> _openVideo(BuildContext context, WidgetRef ref) async {
    final url = 'https://www.youtube.com/watch?v=${item.videoId}';
    
    await ref.read(rssSyncProvider.notifier).markAsRead(item.id);

    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('動画を開けませんでした。')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラーが発生しました: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oshiListAsync = ref.watch(oshiListProvider);
    Color oshiColor = AppColors.primaryPink;

    oshiListAsync.whenData((list) {
      final oshi = list.firstWhere((o) => o.id == item.oshiId, orElse: () => list.first);
      if (oshi.color != null) {
        oshiColor = ColorUtils.fromHex(oshi.color!);
      }
    });

    return GlassCard(
      onTap: () => _openVideo(context, ref),
      borderColor: item.isRead ? AppColors.glassBorder : oshiColor.withValues(alpha: 0.3),
      color: item.isRead ? AppColors.glassWhite : oshiColor.withValues(alpha: 0.05),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedThumbnail(
                  url: item.thumbnailUrl,
                  width: 120,
                  height: 70,
                ),
              ),
              if (!item.isRead)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: oshiColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: oshiColor.withValues(alpha: 0.8),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold,
                    color: item.isRead ? AppColors.textSecondary : AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppDateUtils.relativeTime(item.publishedAt),
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.read(rssSyncProvider.notifier).toggleFavorite(item.id, !item.isFavorite);
                      },
                      child: Icon(
                        item.isFavorite ? Icons.star : Icons.star_border,
                        color: item.isFavorite ? AppColors.warning : Colors.white38,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
