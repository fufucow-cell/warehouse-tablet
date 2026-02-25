import 'package:collection/collection.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:intl/intl.dart';

enum EnumTimeFilter {
  hourMinute,
  monthDay,
  yearMonthDay,
  yearMonth,
  day,
  month,
  year;

  String get title => switch (this) {
        EnumTimeFilter.hourMinute => EnumLocale.engoTabHhMm.tr,
        EnumTimeFilter.monthDay => EnumLocale.engoTabMonthDay.tr,
        EnumTimeFilter.yearMonthDay => EnumLocale.engoTabYearMonthDay.tr,
        EnumTimeFilter.yearMonth => EnumLocale.engoTabYearMonth.tr,
        EnumTimeFilter.day => EnumLocale.engoTabDay.tr,
        EnumTimeFilter.month => EnumLocale.engoTabMonth.tr,
        EnumTimeFilter.year => EnumLocale.engoTabYear.tr,
      };

  DateFormat get dateFormat => switch (this) {
        EnumTimeFilter.hourMinute => DateFormat('HH:mm'),
        EnumTimeFilter.monthDay => DateFormat('MM/dd'),
        EnumTimeFilter.yearMonthDay => DateFormat('yyyy/MM/dd'),
        EnumTimeFilter.yearMonth => DateFormat('yyyy/MM'),
        EnumTimeFilter.day => DateFormat('dd'),
        EnumTimeFilter.month => DateFormat('MM'),
        EnumTimeFilter.year => DateFormat('yyyy'),
      };

  static List<EnumTimeFilter> get getChartList => [
        EnumTimeFilter.yearMonthDay,
        EnumTimeFilter.yearMonth,
        EnumTimeFilter.year,
      ];

  static EnumTimeFilter fromString(String? value) {
    return EnumTimeFilter.getChartList.firstWhereOrNull((e) => e.title == value) ?? EnumTimeFilter.yearMonthDay;
  }
}
