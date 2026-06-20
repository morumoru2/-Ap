import 'package:drift/drift.dart';
import 'oshi_table.dart';

/// YouTube動画アイテムテーブル定義
class YoutubeItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get oshiId => integer().references(
      Oshis, #id,
      onDelete: KeyAction.cascade,
      onUpdate: KeyAction.cascade)();
  TextColumn get videoId => text().unique()();
  TextColumn get title => text()();
  DateTimeColumn get publishedAt => dateTime()();
  TextColumn get thumbnailUrl => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
