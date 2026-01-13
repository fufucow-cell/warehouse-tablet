/// 時間工具類
class TimeUtil {
  /// 取得當前台北時區時間（UTC+8）
  static DateTime getTaipeiTime() {
    return DateTime.now().toUtc().add(const Duration(hours: 8));
  }

  /// 取得當前台北時區時間字串（ISO8601 格式）
  static String getTaipeiTimeString() {
    return getTaipeiTime().toIso8601String();
  }
}
