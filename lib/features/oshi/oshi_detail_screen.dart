import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../database/app_database.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/cached_thumbnail.dart';
import '../../../main.dart';
import 'oshi_provider.dart';
import '../rss/rss_provider.dart';

class OshiDetailScreen extends ConsumerWidget {
  final int oshiId;

  const OshiDetailScreen({super.key, required this.oshiId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oshiAsync = ref.watch(oshiDetailProvider(oshiId));

    return oshiAsync.when(
      data: (oshi) {
        if (oshi == null) {
          return const Scaffold(
            body: Center(child: Text('データが見つかりませんでした。')),
          );
        }

        final oshiColor = oshi.color != null 
            ? ColorUtils.fromHex(oshi.color!) 
            : AppColors.primaryPink;

        final birthday = oshi.birthday != null 
            ? AppDateUtils.tryParse(oshi.birthday) 
            : null;

        final daysLeft = birthday != null 
            ? AppDateUtils.daysUntilBirthday(birthday) 
            : null;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: AppColors.darkBg,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    oshi.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (oshi.imagePath != null && File(oshi.imagePath!).existsSync())
                        Image.file(
                          File(oshi.imagePath!),
                          fit: BoxFit.cover,
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.oshiGradient(oshiColor),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white70,
                          ),
                        ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black54, Colors.transparent, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      oshi.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: oshi.isFavorite ? AppColors.accentPink : Colors.white,
                    ),
                    onPressed: () {
                      ref.read(oshiOperationsProvider).toggleFavorite(oshi.id, !oshi.isFavorite);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      context.push('/oshi-edit', extra: oshi.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _showDeleteDialog(context, ref, oshi),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (oshi.groupName != null && oshi.groupName!.isNotEmpty) ...[
                        Text(
                          oshi.groupName!,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: oshiColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      GlassCard(
                        borderColor: oshiColor.withValues(alpha: 0.2),
                        child: Row(
                          children: [
                            Icon(Icons.cake, color: oshiColor, size: 28),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('誕生日', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                    birthday != null 
                                        ? AppDateUtils.formatDate(birthday) 
                                        : '未設定',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            if (daysLeft != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: oshiColor.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: oshiColor.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  daysLeft == 0 ? '本日誕生日！' : 'あと $daysLeft 日',
                                  style: TextStyle(
                                    color: daysLeft == 0 ? AppColors.accentPink : oshiColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (oshi.memo != null && oshi.memo!.isNotEmpty) ...[
                        const Text(
                          'メモ',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        GlassCard(
                          borderColor: AppColors.glassBorder,
                          child: Text(
                            oshi.memo!,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      if (oshi.youtubeChannelId != null && oshi.youtubeChannelId!.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(Icons.play_circle_fill, color: Colors.red, size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'YouTube 新着動画',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _YoutubeItemsSection(oshiId: oshi.id, oshiColor: oshiColor),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.push(
                                '/diary-edit',
                                extra: {'oshiId': oshi.id},
                              ),
                              icon: const Icon(Icons.book_outlined, size: 18),
                              label: const Text('日記を書く'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.push(
                                '/goods-edit',
                                extra: {'oshiId': oshi.id},
                              ),
                              icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                              label: const Text('グッズ追加'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        body: Center(child: Text('エラーが発生しました: $err')),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, Oshi oshi) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('削除の確認'),
        content: Text('${oshi.name} を削除しますか？\n登録したデータは全て消去されます。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref.read(oshiOperationsProvider).deleteOshi(oshi.id);
              if (context.mounted) {
                context.pop();
              }
            },
            child: const Text('削除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _YoutubeItemsSection extends ConsumerWidget {
  final int oshiId;
  final Color oshiColor;

  const _YoutubeItemsSection({required this.oshiId, required this.oshiColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    
    return FutureBuilder<List<YoutubeItem>>(
      future: db.getYoutubeItemsByOshiId(oshiId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('動画の読み込みに失敗しました: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return GlassCard(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.video_library_outlined, color: Colors.white38, size: 36),
                    const SizedBox(height: 8),
                    const Text(
                      '取得された動画はありません。',
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '「フィード」画面で更新を行うと、RSSから自動で動画が読み込まれます。',
                      style: TextStyle(color: Colors.white30, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CachedThumbnail(
                  url: item.thumbnailUrl,
                  width: 80,
                  height: 45,
                  borderRadius: 4,
                ),
                title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
                subtitle: Text(
                  AppDateUtils.relativeTime(item.publishedAt),
                  style: const TextStyle(fontSize: 11, color: Colors.white38),
                ),
                trailing: Icon(item.isRead ? Icons.check_circle : Icons.circle, color: item.isRead ? Colors.green : oshiColor, size: 16),
                onTap: () async {
                  final url = 'https://www.youtube.com/watch?v=${item.videoId}';
                  await ref.read(rssSyncProvider.notifier).markAsRead(item.id);
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url, mode: LaunchMode.externalApplication);
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}
