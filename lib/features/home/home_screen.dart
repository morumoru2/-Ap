import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/staggered_fade_in.dart';
import 'home_provider.dart';
import 'widgets/oshi_quick_access.dart';
import 'widgets/recent_videos_card.dart';
import 'widgets/upcoming_events_card.dart';
import '../rss/rss_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCountAsync = ref.watch(unreadVideosCountProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.darkGradient,
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(rssSyncProvider.notifier).syncAllFeeds();
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    index: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OshiMemo',
                              style: AppTextStyles.headlineLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '今日の推し活を楽しもう',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.rss_feed, size: 28),
                              onPressed: () => context.go('/feed'),
                            ),
                            unreadCountAsync.when(
                              data: (count) {
                                if (count == 0) return const SizedBox.shrink();
                                return Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.accentPink,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      '$count',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                              loading: () => const SizedBox.shrink(),
                              error: (_, __) => const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    index: 1,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: OshiQuickAccess(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    index: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: GlassCard(
                              onTap: () => context.push('/diary'),
                              padding: const EdgeInsets.all(16),
                              child: const Row(
                                children: [
                                  Icon(Icons.book_outlined, color: AppColors.primaryPink),
                                  SizedBox(width: 12),
                                  Text('推し日記', style: TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GlassCard(
                              onTap: () => context.push('/goods'),
                              padding: const EdgeInsets.all(16),
                              child: const Row(
                                children: [
                                  Icon(Icons.shopping_bag_outlined, color: AppColors.primaryPurple),
                                  SizedBox(width: 12),
                                  Text('グッズ', style: TextStyle(fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    index: 3,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 24),
                      child: UpcomingEventsCard(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StaggeredFadeIn(
                    index: 4,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: RecentVideosCard(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
