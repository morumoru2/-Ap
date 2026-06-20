import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';
import 'icloud_service.dart';

class DatabasePathResolver {
  DatabasePathResolver._();

  /// SQLite ファイルのフルパスを解決（iOS では iCloud Documents を優先）
  static Future<String> resolveDatabasePath() async {
    if (ICloudService.isSupported) {
      final icloudDir = await ICloudService.getDocumentsPath();
      if (icloudDir != null && icloudDir.isNotEmpty) {
        final dir = Directory(icloudDir);
        if (!dir.existsSync()) {
          await dir.create(recursive: true);
        }
        return p.join(icloudDir, AppConstants.dbName);
      }
    }

    final localDir = await getApplicationDocumentsDirectory();
    return p.join(localDir.path, AppConstants.dbName);
  }

  /// ローカルバックアップパス（iCloud 同期用）
  static Future<String> localBackupPath() async {
    final localDir = await getApplicationDocumentsDirectory();
    return p.join(localDir.path, AppConstants.dbName);
  }
}
