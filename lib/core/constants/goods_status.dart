class GoodsStatus {
  GoodsStatus._();

  static const want = 'want';
  static const reserved = 'reserved';
  static const purchased = 'purchased';

  static const labels = {
    want: '欲しい',
    reserved: '予約済',
    purchased: '購入済',
  };

  static String label(String status) => labels[status] ?? status;
}
