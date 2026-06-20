import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/goods_status.dart';
import '../../core/utils/color_utils.dart';
import '../../shared/widgets/animated_fab.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/glass_card.dart';
import '../oshi/oshi_provider.dart';
import 'goods_provider.dart';

class GoodsListScreen extends ConsumerWidget {
  const GoodsListScreen({super.key});

  String _formatYen(int amount) => '¥${amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      )}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goodsAsync = ref.watch(goodsStreamProvider);
    final stats = ref.watch(goodsStatsProvider);
    final oshiListAsync = ref.watch(oshiListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('グッズ管理')),
      body: Column(
        children: [
          if (stats != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: GlassCard(
                borderColor: AppColors.primaryPink.withValues(alpha: 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '購入済み 総額',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatYen(stats.totalAmount),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentPink,
                      ),
                    ),
                    if (stats.amountByOshi.isNotEmpty) ...[
                      const Divider(color: AppColors.glassBorder, height: 20),
                      const Text(
                        '推し別',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      ...stats.amountByOshi.entries.map((e) {
                        String name = 'ID:${e.key}';
                        oshiListAsync.whenData((list) {
                          final oshi =
                              list.where((o) => o.id == e.key).firstOrNull;
                          if (oshi != null) name = oshi.name;
                        });
                        return Padding(
                           padding: const EdgeInsets.only(bottom: 4),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(name, style: const TextStyle(fontSize: 13)),
                               Text(
                                 _formatYen(e.value),
                                 style: const TextStyle(fontSize: 13),
                               ),
                             ],
                           ),
                         );
                       }),
                     ],
                     if (stats.amountByMonth.isNotEmpty) ...[
                       const Divider(color: AppColors.glassBorder, height: 20),
                       const Text(
                         '月別',
                         style: TextStyle(color: Colors.white70, fontSize: 12),
                       ),
                       const SizedBox(height: 8),
                       ...stats.amountByMonth.entries.map((e) {
                         return Padding(
                           padding: const EdgeInsets.only(bottom: 4),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(e.key, style: const TextStyle(fontSize: 13)),
                               Text(
                                 _formatYen(e.value),
                                 style: const TextStyle(fontSize: 13),
                               ),
                             ],
                           ),
                         );
                       }),
                     ],
                   ],
                 ),
               ),
             ),
          Expanded(
            child: goodsAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.shopping_bag_outlined,
                    title: 'グッズがありません',
                    subtitle: '欲しいグッズや購入記録を管理しましょう',
                    action: ElevatedButton(
                      onPressed: () => context.push('/goods-edit'),
                      child: const Text('グッズを追加'),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    Color oshiColor = AppColors.primaryPink;
                    String oshiName = '';

                    oshiListAsync.whenData((list) {
                      final oshi = list.firstWhere(
                        (o) => o.id == item.oshiId,
                        orElse: () => list.first,
                      );
                      oshiName = oshi.name;
                      if (oshi.color != null) {
                        oshiColor = ColorUtils.fromHex(oshi.color!);
                      }
                    });

                    return GlassCard(
                      margin: const EdgeInsets.only(bottom: 10),
                      borderColor: oshiColor.withValues(alpha: 0.2),
                      onTap: () => context.push('/goods-edit', extra: item.id),
                      child: Row(
                        children: [
                          if (item.imagePath != null &&
                              File(item.imagePath!).existsSync())
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(item.imagePath!),
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: oshiColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.shopping_bag, color: oshiColor),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  oshiName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: oshiColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(item.status)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  GoodsStatus.label(item.status),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: _statusColor(item.status),
                                  ),
                                ),
                              ),
                              if (item.price != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _formatYen(item.price!),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
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
        onPressed: () => context.push('/goods-edit'),
        icon: Icons.add,
        tooltip: 'グッズを追加',
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case GoodsStatus.purchased:
        return Colors.greenAccent;
      case GoodsStatus.reserved:
        return Colors.amberAccent;
      default:
        return AppColors.primaryPink;
    }
  }
}
