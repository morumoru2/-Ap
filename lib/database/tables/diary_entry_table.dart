import 'package:drift/drift.dart';
import 'oshi_table.dart';

/// 日記エントリテーブル定義
class DiaryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get oshiId => integer().references(
      Oshis, #id,
      onDelete: KeyAction.cascade,
      onUpdate: KeyAction.cascade)();
  TextColumn get content => text()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get tags => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
