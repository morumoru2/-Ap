import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _dateFormat = DateFormat('yyyy/MM/dd');
  static final DateFormat _dateTimeFormat = DateFormat('yyyy/MM/dd HH:mm');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _monthDayFormat = DateFormat('M/d');
  static final DateFormat _yearMonthFormat = DateFormat('yyyy年M月');

  /// 日付を yyyy/MM/dd 形式にフォーマット
  static String formatDate(DateTime date) => _dateFormat.format(date);

  /// 日時を yyyy/MM/dd HH:mm 形式にフォーマット
  static String formatDateTime(DateTime date) => _dateTimeFormat.format(date);

  /// 時刻を HH:mm 形式にフォーマット
  static String formatTime(DateTime date) => _timeFormat.format(date);

  /// M/d 形式にフォーマット
  static String formatMonthDay(DateTime date) => _monthDayFormat.format(date);

  /// yyyy年M月 形式にフォーマット
  static String formatYearMonth(DateTime date) => _yearMonthFormat.format(date);

  /// 相対時間を返す（例: 3分前, 2時間前, 昨日）
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'たった今';
    if (diff.inMinutes < 60) return '${diff.inMinutes}分前';
    if (diff.inHours < 24) return '${diff.inHours}時間前';
    if (diff.inDays < 2) return '昨日';
    if (diff.inDays < 7) return '${diff.inDays}日前';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}週間前';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}ヶ月前';
    return '${(diff.inDays / 365).floor()}年前';
  }

  /// 誕生日までの日数を計算
  static int daysUntilBirthday(DateTime birthday) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    var nextBirthday = DateTime(now.year, birthday.month, birthday.day);
    if (nextBirthday.isBefore(today)) {
      nextBirthday = DateTime(now.year + 1, birthday.month, birthday.day);
    }
    return nextBirthday.difference(today).inDays;
  }

  /// ISO8601文字列をパース
  static DateTime? tryParse(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    return DateTime.tryParse(dateString);
  }
}
