import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/widgets/empty_state.dart';
import 'rss_provider.dart';
import 'widgets/video_card.dart';

class RssFeedScreen extends ConsumerWidget {
  const RssFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final youtubeItemsAsync = ref.watch(youtubeItemsStreamProvider);
    final syncState = ref.watch(rssSyncProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('新着フィード'),
        actions: [
          IconButton(
            icon: syncState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.refresh),
            onPressed: syncState.isLoading
                ? null
                : () async {
                    await ref.read(rssSyncProvider.notifier).syncAllFeeds();
                  },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(rssSyncProvider.notifier).syncAllFeeds();
        },
        child: youtubeItemsAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return EmptyState(
                icon: Icons.rss_feed,
                title: '動画が見つかりません',
                subtitle: '右上の更新ボタンを押すか、推しを追加してYouTubeチャンネルIDを設定してください。',
                action: ElevatedButton(
                  onPressed: syncState.isLoading
                      ? null
                      : () => ref.read(rssSyncProvider.notifier).syncAllFeeds(),
                  child: const Text('動画を読み込む'),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return VideoCard(item: items[index]);
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) => Center(
            child: Text('エラーが発生しました: $err'),
          ),
        ),
      ),
    );
  }
}
