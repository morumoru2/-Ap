import 'database_path_resolver.dart';
import 'icloud_service.dart';

class ICloudSyncService {
  ICloudSyncService._();

  /// 起動時: iCloud から最新 DB を取得
  static Future<bool> pullOnLaunch() async {
    if (!ICloudService.isSupported) return false;
    final localPath = await DatabasePathResolver.resolveDatabasePath();
    return ICloudService.pullDatabaseIfNewer(localPath);
  }

  /// バックグラウンド/終了時: iCloud へアップロード
  static Future<bool> pushOnBackground() async {
    if (!ICloudService.isSupported) return false;
    final localPath = await DatabasePathResolver.resolveDatabasePath();
    return ICloudService.pushDatabase(localPath);
  }
}
