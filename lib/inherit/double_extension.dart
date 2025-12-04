// 由 DeviceUtil 初始化後設置
double scaleMin = 0.0;
double scaleWidth = 0.0;
double scaleHeight = 0.0;

extension DoubleExtension on double {

  // 最小縮放比
  double get scale => this * scaleMin;

  // 寬度縮放比
  double get scaleW => this * scaleWidth;

  // 高度縮放比
  double get scaleH => this * scaleHeight;
}
