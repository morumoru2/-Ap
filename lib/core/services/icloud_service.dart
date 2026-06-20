import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_constants.dart';

class ICloudService {
  ICloudService._();

  static const _channel = MethodChannel('com.oshimemo.oshi_memo/icloud');
  static const _containerId = 'iCloud.com.oshimemo.oshiMemo';

  static bool get isSupported => !kIsWeb && Platform.isIOS;

  /// iCloud Documents ディレクトリ（利用不可なら null）
  static Future<String?> getDocumentsPath() async {
    if (!isSupported) return null;
    try {
      final path = await _channel.invokeMethod<String>('getICloudDocumentsPath');
      return path;
    } catch (_) {
      return null;
    }
  }

  /// ローカル DB を iCloud にアップロード
  static Future<bool> pushDatabase(String localDbPath) async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>(
            'pushDatabase',
            {'localPath': localDbPath, 'fileName': AppConstants.dbName},
          ) ??
          false;
    } catch (_) {
      return false;
    }
  }

  /// iCloud 側が新しければローカルへダウンロード
  static Future<bool> pullDatabaseIfNewer(String localDbPath) async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>(
            'pullDatabaseIfNewer',
            {'localPath': localDbPath, 'fileName': AppConstants.dbName},
          ) ??
          false;
    } catch (_) {
      return false;
    }
  }

  /// iCloud が有効か
  static Future<bool> isAvailable() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('isICloudAvailable') ?? false;
    } catch (_) {
      return false;
    }
  }

  static String get containerId => _containerId;
}
