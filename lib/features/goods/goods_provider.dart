import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../database/app_database.dart';

final goodsStreamProvider = StreamProvider<List<Good>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllGoods();
});

final goodsStatsProvider = Provider<GoodsStats?>((ref) {
  final goodsAsync = ref.watch(goodsStreamProvider);
  return goodsAsync.when(
    data: (items) {
      final total = items
          .where((item) => item.status == 'purchased')
          .fold<int>(0, (sum, item) => sum + (item.price ?? 0));

      final byOshi = <int, int>{};
      final byMonth = <String, int>{};
      for (final item in items.where((item) => item.status == 'purchased')) {
        byOshi[item.oshiId] = (byOshi[item.oshiId] ?? 0) + (item.price ?? 0);
        final key =
            '${item.createdAt.year}-${item.createdAt.month.toString().padLeft(2, '0')}';
        byMonth[key] = (byMonth[key] ?? 0) + (item.price ?? 0);
      }
      return GoodsStats(
        totalAmount: total,
        amountByOshi: byOshi,
        amountByMonth: byMonth,
      );
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

final goodsOperationsProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return GoodsOperations(db);
});

class GoodsStats {
  final int totalAmount;
  final Map<int, int> amountByOshi;
  final Map<String, int> amountByMonth;

  GoodsStats({
    required this.totalAmount,
    required this.amountByOshi,
    required this.amountByMonth,
  });
}

class GoodsOperations {
  final AppDatabase _db;
  GoodsOperations(this._db);

  Future<int> addGood(GoodsCompanion good) => _db.insertGood(good);

  Future<bool> updateGood(GoodsCompanion good) => _db.updateGood(good);

  Future<void> deleteGood(int id) => _db.deleteGood(id);
}
