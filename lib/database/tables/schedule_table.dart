import 'package:drift/drift.dart';
import 'oshi_table.dart';

/// スケジュールテーブル定義
class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get oshiId => integer().references(
      Oshis, #id,
      onDelete: KeyAction.cascade,
      onUpdate: KeyAction.cascade)();
  TextColumn get title => text()();
  DateTimeColumn get eventDate => dateTime()();
  TextColumn get eventType => text().withDefault(const Constant('other'))();
  BoolColumn get notificationEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
