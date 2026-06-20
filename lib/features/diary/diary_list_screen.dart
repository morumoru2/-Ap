import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/date_utils.dart';
import '../../shared/widgets/animated_fab.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/glass_card.dart';
import '../oshi/oshi_provider.dart';
import 'diary_provider.dart';

class DiaryListScreen extends ConsumerStatefulWidget {
  const DiaryListScreen({super.key});

  @override
  ConsumerState<DiaryListScreen> createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends ConsumerState<DiaryListScreen> {
  int? _filterOshiId;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(diaryEntriesStreamProvider);
    final oshiListAsync = ref.watch(oshiListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('推し日記'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: _DiarySearchDelegate(ref: ref),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          oshiListAsync.when(
            data: (oshis) {
              if (oshis.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('すべて'),
                        selected: _filterOshiId == null,
                        onSelected: (_) => setState(() => _filterOshiId = null),
                      ),
                    ),
                    ...oshis.map((o) {
                      final color = o.color != null
                          ? ColorUtils.fromHex(o.color!)
                          : AppColors.primaryPink;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(o.name),
                          selected: _filterOshiId == o.id,
                          selectedColor: color.withValues(alpha: 0.3),
                          onSelected: (_) =>
                              setState(() => _filterOshiId = o.id),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          Expanded(
            child: entriesAsync.when(
              data: (entries) {
                final filtered = _filterOshiId == null
                    ? entries
                    : entries.where((e) => e.oshiId == _filterOshiId).toList();

                if (filtered.isEmpty) {
                  return EmptyState(
                    icon: Icons.book_outlined,
                    title: '日記がありません',
                    subtitle: '推し活の記録を残しましょう',
                    action: ElevatedButton(
                      onPressed: () => context.push('/diary-edit'),
                      child: const Text('日記を書く'),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final entry = filtered[index];
                    return _DiaryCard(entry: entry);
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('エラー: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedFab(
        onPressed: () => context.push('/diary-edit'),
        icon: Icons.edit,
        tooltip: '日記を書く',
      ),
    );
  }
}

class _DiaryCard extends ConsumerWidget {
  final dynamic entry;

  const _DiaryCard({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final oshiListAsync = ref.watch(oshiListProvider);
    String oshiName = '';
    Color oshiColor = AppColors.primaryPink;

    oshiListAsync.whenData((list) {
      final oshi = list.firstWhere(
        (o) => o.id == entry.oshiId,
        orElse: () => list.first,
      );
      oshiName = oshi.name;
      if (oshi.color != null) {
        oshiColor = ColorUtils.fromHex(oshi.color!);
      }
    });

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      borderColor: oshiColor.withValues(alpha: 0.2),
      onTap: () => context.push('/diary-edit', extra: entry.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                oshiName,
                style: TextStyle(
                  color: oshiColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                AppDateUtils.formatDateTime(entry.createdAt),
                style: const TextStyle(fontSize: 11, color: Colors.white38),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry.content,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          if (entry.tags != null && entry.tags!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: entry.tags!
                  .split(',')
                  .map((t) => Chip(
                        label: Text(t.trim(), style: const TextStyle(fontSize: 10)),
                        visualDensity: VisualDensity.compact,
                      ))
                  .toList(),
            ),
          ],
          if (entry.imagePath != null &&
              File(entry.imagePath!).existsSync()) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(entry.imagePath!),
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DiarySearchDelegate extends SearchDelegate<void> {
  final WidgetRef ref;

  _DiarySearchDelegate({required this.ref});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => _buildList();

  @override
  Widget buildSuggestions(BuildContext context) => _buildList();

  Widget _buildList() {
    final entriesAsync = ref.watch(diaryEntriesStreamProvider);
    return entriesAsync.when(
      data: (entries) {
        final results = entries.where((e) {
          if (query.isEmpty) return true;
          return e.content.contains(query) ||
              (e.tags?.contains(query) ?? false);
        }).toList();

        if (results.isEmpty) {
          return const Center(child: Text('見つかりませんでした'));
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(results[i].content, maxLines: 2),
            subtitle: Text(AppDateUtils.formatDateTime(results[i].createdAt)),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
