import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/animated_fab.dart';
import '../../shared/widgets/empty_state.dart';
import '../../database/app_database.dart';
import 'oshi_provider.dart';
import 'widgets/oshi_card.dart';

class OshiListScreen extends ConsumerStatefulWidget {
  const OshiListScreen({super.key});

  @override
  ConsumerState<OshiListScreen> createState() => _OshiListScreenState();
}

class _OshiListScreenState extends ConsumerState<OshiListScreen> {
  bool _isReorderMode = false;
  List<Oshi> _reorderList = [];

  @override
  Widget build(BuildContext context) {
    final oshiListAsync = ref.watch(oshiListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isReorderMode ? '並び替え' : '推しリスト'),
        actions: [
          oshiListAsync.when(
            data: (oshis) {
              if (oshis.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(_isReorderMode ? Icons.check : Icons.sort),
                tooltip: _isReorderMode ? '完了' : '並び替え',
                onPressed: () async {
                  if (_isReorderMode) {
                    await ref
                        .read(oshiOperationsProvider)
                        .updateSortOrders(_reorderList);
                    setState(() => _isReorderMode = false);
                  } else {
                    setState(() {
                      _isReorderMode = true;
                      _reorderList = List.from(oshis);
                    });
                  }
                },
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, AppColors.darkBg],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: oshiListAsync.when(
        data: (oshis) {
          if (oshis.isEmpty) {
            return EmptyState(
              icon: Icons.favorite_border,
              title: '推しが登録されていません',
              subtitle: '右下の「＋」ボタンからあなたの推しを登録しましょう！',
              action: ElevatedButton(
                onPressed: () => context.push('/oshi-edit'),
                child: const Text('推しを登録する'),
              ),
            );
          }

          if (_isReorderMode) {
            return ReorderableListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _reorderList.length,
              onReorderItem: (oldIndex, newIndex) {
                setState(() {
                  final item = _reorderList.removeAt(oldIndex);
                  _reorderList.insert(newIndex, item);
                });
              },
              itemBuilder: (context, index) {
                final oshi = _reorderList[index];
                return ListTile(
                  key: ValueKey(oshi.id),
                  leading: const Icon(Icons.drag_handle),
                  title: Text(oshi.name),
                  subtitle: oshi.groupName != null ? Text(oshi.groupName!) : null,
                  trailing: oshi.isFavorite
                      ? const Icon(Icons.favorite, color: AppColors.accentPink, size: 18)
                      : null,
                );
              },
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: oshis.length,
            itemBuilder: (context, index) {
              return OshiCard(oshi: oshis[index]);
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
      floatingActionButton: _isReorderMode
          ? null
          : AnimatedFab(
              onPressed: () => context.push('/oshi-edit'),
              icon: Icons.add,
              tooltip: '推しを追加',
            ),
    );
  }
}
