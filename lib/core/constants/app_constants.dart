class AppConstants {
  AppConstants._();

  static const String appName = 'OshiMemo';
  static const String appVersion = '1.0.0';

  // RSS
  static const String youtubeRssBaseUrl =
      'https://www.youtube.com/feeds/videos.xml?channel_id=';
  static const Duration rssTimeout = Duration(seconds: 10);
  static const int maxRssItems = 50;

  // Animation
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // UI
  static const double cardBorderRadius = 16.0;
  static const double glassBlurSigma = 20.0;
  static const double cardPadding = 16.0;
  static const double screenPadding = 20.0;

  // DB
  static const String dbName = 'oshi_memo.db';
  static const int dbVersion = 1;
}
