import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../../database/app_database.dart';

final diaryEntriesStreamProvider = StreamProvider<List<DiaryEntry>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllDiaryEntries();
});

final diaryOperationsProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return DiaryOperations(db);
});

class DiaryOperations {
  final AppDatabase _db;
  DiaryOperations(this._db);

  Future<int> addEntry(DiaryEntriesCompanion entry) => _db.insertDiaryEntry(entry);

  Future<bool> updateEntry(DiaryEntriesCompanion entry) =>
      _db.updateDiaryEntry(entry);

  Future<void> deleteEntry(int id) => _db.deleteDiaryEntry(id);
}
