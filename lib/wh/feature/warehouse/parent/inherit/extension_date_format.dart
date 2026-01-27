import 'package:engo_terminal_app3/wh/feature/air_box/page/record/air_box_record_page_model.dart';
import 'package:intl/intl.dart';

/// DateTime 格式化擴充方法
extension DateTimeFormatExtension on DateTime {
  /// 根據時間篩選類型格式化日期
  ///
  /// - [EnumTimeFilter.day]: 格式為 'yyyy/MM/dd'
  /// - [EnumTimeFilter.month]: 格式為 'yyyy/MM'
  /// - [EnumTimeFilter.year]: 格式為 'yyyy'
  String formatByTimeFilter(EnumTimeFilter timeFilter) {
    switch (timeFilter) {
      case EnumTimeFilter.day:
        return DateFormat('yyyy/MM/dd').format(this);
      case EnumTimeFilter.month:
        return DateFormat('yyyy/MM').format(this);
      case EnumTimeFilter.year:
        return DateFormat('yyyy').format(this);
    }
  }
}
