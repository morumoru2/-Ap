import 'package:home_widget/home_widget.dart';
import '../../core/constants/widget_keys.dart';
import '../../database/app_database.dart';
import '../utils/date_utils.dart';

class WidgetUpdateService {
  WidgetUpdateService._();

  static Future<void> init() async {
    try {
      await HomeWidget.setAppGroupId(WidgetKeys.appGroupId);
    } catch (_) {
      // Android 等では App Group 不要
    }
  }

  static Future<void> updateFromDatabase(AppDatabase db) async {
    try {
      await init();

      final oshis = await db.getAllOshis();
      final schedules = await db.getAllSchedules();
      final videos = await db.watchAllYoutubeItems().first;
      final unread = videos.where((v) => !v.isRead).length;

      // 次のイベント
      String nextEventTitle = '予定なし';
      String nextEventDays = '-';
      final now = DateTime.now();
      DateTime? nearestDate;

      for (final s in schedules) {
        if (s.eventDate.isAfter(now)) {
          if (nearestDate == null || s.eventDate.isBefore(nearestDate)) {
            nearestDate = s.eventDate;
            nextEventTitle = s.title;
            final days = s.eventDate.difference(now).inDays;
            nextEventDays = days == 0 ? '本日' : 'あと$days日';
          }
        }
      }

      for (final o in oshis) {
        final birthday = AppDateUtils.tryParse(o.birthday);
        if (birthday == null) continue;
        final daysLeft = AppDateUtils.daysUntilBirthday(birthday);
        if (daysLeft <= 30) {
          final bdayDate = DateTime(now.year, birthday.month, birthday.day);
          final target = bdayDate.isBefore(now)
              ? DateTime(now.year + 1, birthday.month, birthday.day)
              : bdayDate;
          if (nearestDate == null || target.isBefore(nearestDate)) {
            nearestDate = target;
            nextEventTitle = '${o.name} の誕生日';
            nextEventDays = daysLeft == 0 ? '本日' : 'あと$daysLeft日';
          }
        }
      }

      // 最新動画
      String latestVideoTitle = '動画なし';
      String latestOshiName = '';
      if (videos.isNotEmpty) {
        latestVideoTitle = videos.first.title;
        final oshi = oshis.where((o) => o.id == videos.first.oshiId).firstOrNull;
        latestOshiName = oshi?.name ?? '';
      }

      // 誕生日カウントダウン
      String birthdayText = '';
      for (final o in oshis) {
        final birthday = AppDateUtils.tryParse(o.birthday);
        if (birthday == null) continue;
        final daysLeft = AppDateUtils.daysUntilBirthday(birthday);
        if (daysLeft <= 7) {
          birthdayText = daysLeft == 0
              ? '${o.name} 本日誕生日！'
              : '${o.name} 誕生日まで $daysLeft 日';
          break;
        }
      }

      await HomeWidget.saveWidgetData<String>(
        WidgetKeys.nextEventTitle,
        nextEventTitle,
      );
      await HomeWidget.saveWidgetData<String>(
        WidgetKeys.nextEventDays,
        nextEventDays,
      );
      await HomeWidget.saveWidgetData<String>(
        WidgetKeys.latestVideoTitle,
        latestVideoTitle,
      );
      await HomeWidget.saveWidgetData<String>(
        WidgetKeys.latestOshiName,
        latestOshiName,
      );
      await HomeWidget.saveWidgetData<String>(
        WidgetKeys.birthdayText,
        birthdayText,
      );
      await HomeWidget.saveWidgetData<int>(
        WidgetKeys.unreadCount,
        unread,
      );

      await HomeWidget.updateWidget(
        iOSName: WidgetKeys.iOSWidgetName,
        androidName: WidgetKeys.widgetName,
      );
    } catch (_) {
      // Widget 未設定環境では無視
    }
  }
}
