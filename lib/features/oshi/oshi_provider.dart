import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../database/app_database.dart';

/// 全ての推しリストをリアルタイムに監視するStreamProvider
final oshiListProvider = StreamProvider<List<Oshi>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllOshis();
});

/// 特定の推しをリアルタイムに監視するStreamProvider
final oshiDetailProvider = StreamProvider.family<Oshi?, int>((ref, id) {
  final db = ref.watch(databaseProvider);
  return db.watchOshiById(id);
});

/// 推し関連の操作を行うNotifier
final oshiOperationsProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return OshiOperations(db);
});

class OshiOperations {
  final AppDatabase _db;
  OshiOperations(this._db);

  Future<int> addOshi(OshisCompanion oshi) {
    return _db.insertOshi(oshi);
  }

  Future<bool> updateOshi(OshisCompanion oshi) {
    return _db.updateOshi(oshi);
  }

  Future<int> deleteOshi(int id) {
    return _db.deleteOshi(id);
  }

  Future<void> toggleFavorite(int id, bool isFavorite) {
    return _db.toggleOshiFavorite(id, isFavorite);
  }

  Future<void> updateSortOrders(List<Oshi> orderedOshis) {
    return _db.updateOshiSortOrders(orderedOshis);
  }
}
