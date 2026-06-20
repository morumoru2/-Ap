import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import '../core/constants/app_constants.dart';
import '../core/services/database_path_resolver.dart';
import 'tables/oshi_table.dart';
import 'tables/youtube_item_table.dart';
import 'tables/diary_entry_table.dart';
import 'tables/goods_table.dart';
import 'tables/schedule_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Oshis, YoutubeItems, DiaryEntries, Goods, Schedules],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.atPath(String path) : super(_openConnectionAt(path));

  @override
  int get schemaVersion => AppConstants.dbVersion;

  // === 推し CRUD ===

  /// 全推し取得（ソート順）
  Future<List<Oshi>> getAllOshis() {
    return (select(oshis)
          ..orderBy([
            (t) => OrderingTerm(expression: t.isFavorite, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.sortOrder),
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// 推しをリアルタイム監視
  Stream<List<Oshi>> watchAllOshis() {
    return (select(oshis)
          ..orderBy([
            (t) => OrderingTerm(expression: t.isFavorite, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.sortOrder),
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// 推しをIDで取得
  Future<Oshi?> getOshiById(int id) {
    return (select(oshis)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// 推しをIDでリアルタイム監視
  Stream<Oshi?> watchOshiById(int id) {
    return (select(oshis)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// 推し登録
  Future<int> insertOshi(OshisCompanion oshi) {
    return into(oshis).insert(oshi);
  }

  /// 推し更新
  Future<bool> updateOshi(OshisCompanion oshi) {
    return (update(oshis)..where((t) => t.id.equals(oshi.id.value)))
        .write(oshi.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  /// 推し削除
  Future<int> deleteOshi(int id) {
    return (delete(oshis)..where((t) => t.id.equals(id))).go();
  }

  /// お気に入りトグル
  Future<void> toggleOshiFavorite(int id, bool isFavorite) {
    return (update(oshis)..where((t) => t.id.equals(id)))
        .write(OshisCompanion(isFavorite: Value(isFavorite)));
  }

  // === YouTube CRUD ===

  /// 推しIDでYouTube動画一覧取得
  Future<List<YoutubeItem>> getYoutubeItemsByOshiId(int oshiId) {
    return (select(youtubeItems)
          ..where((t) => t.oshiId.equals(oshiId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.publishedAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  /// 全YouTube動画取得（新着順）
  Stream<List<YoutubeItem>> watchAllYoutubeItems() {
    return (select(youtubeItems)
          ..orderBy([
            (t) => OrderingTerm(expression: t.publishedAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// 未読YouTube動画数
  Future<int> getUnreadYoutubeCount() async {
    final count = youtubeItems.id.count();
    final query = selectOnly(youtubeItems)
      ..addColumns([count])
      ..where(youtubeItems.isRead.equals(false));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// YouTube動画の挿入（重複はスキップ）。新規挿入時 true
  Future<bool> insertYoutubeItem(YoutubeItemsCompanion item) async {
    final inserted = await into(youtubeItems).insert(
      item,
      mode: InsertMode.insertOrIgnore,
    );
    return inserted > 0;
  }

  /// 推しの並び順を更新
  Future<void> updateOshiSortOrders(List<Oshi> orderedOshis) async {
    await batch((batch) {
      for (var i = 0; i < orderedOshis.length; i++) {
        batch.update(
          oshis,
          OshisCompanion(sortOrder: Value(i)),
          where: (t) => t.id.equals(orderedOshis[i].id),
        );
      }
    });
  }

  // === スケジュール CRUD ===

  Future<List<Schedule>> getAllSchedules() {
    return (select(schedules)
          ..orderBy([
            (t) => OrderingTerm(expression: t.eventDate),
          ]))
        .get();
  }

  Stream<List<Schedule>> watchAllSchedules() {
    return (select(schedules)
          ..orderBy([
            (t) => OrderingTerm(expression: t.eventDate),
          ]))
        .watch();
  }

  Future<List<Schedule>> getSchedulesByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(schedules)
          ..where((t) =>
              t.eventDate.isBiggerOrEqualValue(start) &
              t.eventDate.isSmallerThanValue(end))
          ..orderBy([
            (t) => OrderingTerm(expression: t.eventDate),
          ]))
        .get();
  }

  Future<Schedule?> getScheduleById(int id) {
    return (select(schedules)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertSchedule(SchedulesCompanion schedule) {
    return into(schedules).insert(schedule);
  }

  Future<bool> updateSchedule(SchedulesCompanion schedule) {
    return (update(schedules)..where((t) => t.id.equals(schedule.id.value)))
        .write(schedule)
        .then((rows) => rows > 0);
  }

  Future<int> deleteSchedule(int id) {
    return (delete(schedules)..where((t) => t.id.equals(id))).go();
  }

  // === 日記 CRUD ===

  Future<List<DiaryEntry>> getAllDiaryEntries() {
    return (select(diaryEntries)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Stream<List<DiaryEntry>> watchAllDiaryEntries() {
    return (select(diaryEntries)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<DiaryEntry>> getDiaryEntriesByOshiId(int oshiId) {
    return (select(diaryEntries)
          ..where((t) => t.oshiId.equals(oshiId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<DiaryEntry?> getDiaryEntryById(int id) {
    return (select(diaryEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertDiaryEntry(DiaryEntriesCompanion entry) {
    return into(diaryEntries).insert(entry);
  }

  Future<bool> updateDiaryEntry(DiaryEntriesCompanion entry) {
    return (update(diaryEntries)..where((t) => t.id.equals(entry.id.value)))
        .write(entry.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  Future<int> deleteDiaryEntry(int id) {
    return (delete(diaryEntries)..where((t) => t.id.equals(id))).go();
  }

  // === グッズ CRUD ===

  Future<List<Good>> getAllGoods() {
    return (select(goods)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Stream<List<Good>> watchAllGoods() {
    return (select(goods)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<Good>> getGoodsByOshiId(int oshiId) {
    return (select(goods)
          ..where((t) => t.oshiId.equals(oshiId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<Good?> getGoodById(int id) {
    return (select(goods)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertGood(GoodsCompanion good) {
    return into(goods).insert(good);
  }

  Future<bool> updateGood(GoodsCompanion good) {
    return (update(goods)..where((t) => t.id.equals(good.id.value)))
        .write(good.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  Future<int> deleteGood(int id) {
    return (delete(goods)..where((t) => t.id.equals(id))).go();
  }

  /// 購入済みグッズの総額
  Future<int> getTotalPurchasedAmount() async {
    final purchased = await (select(goods)
          ..where((t) => t.status.equals('purchased')))
        .get();
    return purchased.fold<int>(0, (sum, g) => sum + (g.price ?? 0));
  }

  /// 推し別購入額
  Future<Map<int, int>> getPurchasedAmountByOshi() async {
    final purchased = await (select(goods)
          ..where((t) => t.status.equals('purchased')))
        .get();
    final map = <int, int>{};
    for (final g in purchased) {
      map[g.oshiId] = (map[g.oshiId] ?? 0) + (g.price ?? 0);
    }
    return map;
  }

  /// 月別購入額 (yyyy-MM -> amount)
  Future<Map<String, int>> getPurchasedAmountByMonth() async {
    final purchased = await (select(goods)
          ..where((t) => t.status.equals('purchased')))
        .get();
    final map = <String, int>{};
    for (final g in purchased) {
      final key =
          '${g.createdAt.year}-${g.createdAt.month.toString().padLeft(2, '0')}';
      map[key] = (map[key] ?? 0) + (g.price ?? 0);
    }
    return map;
  }

  /// YouTube動画の既読設定
  Future<void> markYoutubeItemAsRead(int id) {
    return (update(youtubeItems)..where((t) => t.id.equals(id)))
        .write(const YoutubeItemsCompanion(isRead: Value(true)));
  }

  /// YouTube動画のお気に入りトグル
  Future<void> toggleYoutubeItemFavorite(int id, bool isFavorite) {
    return (update(youtubeItems)..where((t) => t.id.equals(id)))
        .write(YoutubeItemsCompanion(isFavorite: Value(isFavorite)));
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final path = await DatabasePathResolver.resolveDatabasePath();
    return NativeDatabase.createInBackground(File(path));
  });
}

LazyDatabase _openConnectionAt(String path) {
  return LazyDatabase(() async {
    return NativeDatabase.createInBackground(File(path));
  });
}
