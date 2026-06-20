import 'package:drift/drift.dart';

/// 推しテーブル定義
class Oshis extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get groupName => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get birthday => text().nullable()();
  TextColumn get memo => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get youtubeChannelId => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
