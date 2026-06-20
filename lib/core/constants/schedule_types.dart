class ScheduleTypes {
  ScheduleTypes._();

  static const live = 'live';
  static const stream = 'stream';
  static const birthday = 'birthday';
  static const goodsRelease = 'goods_release';
  static const event = 'event';
  static const other = 'other';

  static const labels = {
    live: 'ライブ',
    stream: '配信',
    birthday: '誕生日',
    goodsRelease: 'グッズ発売',
    event: 'イベント',
    other: 'その他',
  };

  static String label(String type) => labels[type] ?? type;
}
