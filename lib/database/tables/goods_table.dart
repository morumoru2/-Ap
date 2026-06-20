import 'package:drift/drift.dart';
import 'oshi_table.dart';

/// グッズテーブル定義
class Goods extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get oshiId => integer().references(
      Oshis, #id,
      onDelete: KeyAction.cascade,
      onUpdate: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get price => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('want'))();
  TextColumn get imagePath => text().nullable()();
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
