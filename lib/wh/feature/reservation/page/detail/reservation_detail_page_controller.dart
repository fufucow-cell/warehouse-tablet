import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/ui/image_viewer.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/specific_date_response_model/specific_date_response_model.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/period.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/weekly_repeat_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'reservation_detail_page_interactive.dart';
part 'reservation_detail_page_route.dart';

class ReservationDetailPageController extends GetxController {
  // MARK: - Properties

  final _model = ReservationDetailPageModel();
  ReservationService get _service => ReservationService.instance;
  ReservableItemModel? get getReservableItem => _model.routeData?.reservableItem ?? _model.routeData?.recordItem?.itemReservableInfo;
  RecordItemModel? get getRecordItem => _model.routeData?.recordItem;
  RxReadonly<DateTime?> get dateRx => _model.date.readonly;
  RxReadonly<String?> get selectedDateRx => _model.selectedDate.readonly;
  RxReadonly<TimeOfDay?> get startTimeRx => _model.startTime.readonly;
  RxReadonly<TimeOfDay?> get endTimeRx => _model.endTime.readonly;
  RxReadonly<String> get totalBillingRx => _model.totalBilling.readonly;
  RxReadonly<String> get totalDurationRx => _model.totalDuration.readonly;
  RxReadonly<EnumReservationInfoTabType> get infoTabTypeRx => _model.infoTabType.readonly;
  List<String> get getInfoTabTitles => EnumReservationInfoTabType.values.map((item) => item.title).toList();
  DateTime get firstDate => _model.firstDate;
  DateTime get lastDate => _model.lastDate;
  bool get isReservableDetail => _model.routeData?.reservableItem != null;
  final TextEditingController adultTextController = TextEditingController(text: '1');
  final TextEditingController childTextController = TextEditingController(text: '0');
  String get getAppBarTitle => isReservableDetail ? '預約項目' : '預約記錄';

  // MARK: - Init

  ReservationDetailPageController(ReservationDetailRouteData routeData) {
    _model.routeData = routeData;
    _checkTotalBillingText();

    if (!isReservableDetail) {
      _model.date.value = DateTime.fromMillisecondsSinceEpoch(
        getRecordItem?.bookingStartAt ?? 0,
      );
      _model.startTime.value = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(
          getRecordItem?.bookingStartAt ?? 0,
        ),
      );
      _model.endTime.value = TimeOfDay.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(
          getRecordItem?.bookingEndAt ?? 0,
        ),
      );
      adultTextController.text = getRecordItem?.adultCount.toString() ?? '-';
      childTextController.text = getRecordItem?.childCount.toString() ?? '-';
    }
  }

  @override
  void onClose() {
    adultTextController.dispose();
    childTextController.dispose();
    super.onClose();
  }

  // MARK: - Public Methods

  String get getPositionText {
    final categories = [
      getReservableItem?.categoryLv1Text ?? '',
      getReservableItem?.categoryLv2Text ?? '',
      getReservableItem?.categoryLv3Text ?? '',
    ];

    categories.removeWhere((element) => element.isEmpty);
    return categories.isEmpty ? '-' : categories.join(' / ');
  }

  bool get isShowReservationBookingLimitTypeText => getReservableItem?.bookingLimitType != EnumReservationBookingLimitType.unlimited;

  String get getReservationBookingLimitTypeText {
    final type = getReservableItem?.bookingLimitType ?? EnumReservationBookingLimitType.unlimited;
    return type.localeTitle;
  }

  bool get isShowReservationDateRuleTypeText => getReservableItem?.dateRuleType != EnumReservationDateRuleType.unlimited;

  bool get isShowWeeklyRepeatInfo => getReservableItem?.dateRuleType == EnumReservationDateRuleType.weekly;

  EnumReservationDateRuleType get dateRuleType => getReservableItem?.dateRuleType ?? EnumReservationDateRuleType.unlimited;

  List<SpecificDateResponseModel> get getSpecificDateList => getReservableItem?.specificDate ?? const [];

  List<WeeklyRepeatResponseModel> getEnableWeekDayList() {
    final list = getReservableItem?.weeklyRepeat ?? const [];
    return list.where((e) => e.isEnable == true).toList();
  }

  /// 1=週一 .. 7=週日，之後可改為多語系
  String getWeekDayDisplayText(int? day) {
    if (day == null || day < 1 || day > 7) return '';
    const labels = ['', '週一', '週二', '週三', '週四', '週五', '週六', '週日'];
    return labels[day];
  }

  /// 特定日期下拉選單的目前顯示值（selectedDate 或由 date 格式化成日期字串）
  String? get selectedDateDisplayForSpecificDate =>
      _model.selectedDate.value ?? (_model.date.value != null ? formatDate(_model.date.value!.millisecondsSinceEpoch) : null);

  /// 每週重複下拉選單的目前顯示值（selectedDate 或由 date 對應的星期）
  String? get selectedDateDisplayForWeekly =>
      _model.selectedDate.value ?? (_model.date.value != null ? getWeekDayDisplayText(_model.date.value!.weekday) : null);

  /// 在 [firstDate, lastDate] 區間內，該星期幾的第一次出現日期。day 1=週一..7=週日。
  DateTime? getFirstDateForWeekday(int day) {
    var d = DateTime(firstDate.year, firstDate.month, firstDate.day);
    final last = DateTime(lastDate.year, lastDate.month, lastDate.day);
    while (!d.isAfter(last)) {
      if (d.weekday == day) return d;
      d = d.add(const Duration(days: 1));
    }
    return null;
  }

  String formatPeriod(Period p) {
    final start = p.startTime ?? '--:--';
    final end = p.endTime ?? '--:--';
    return '$start - $end';
  }

  String get getReservationDateRuleTypeText {
    final type = getReservableItem?.dateRuleType ?? EnumReservationDateRuleType.unlimited;
    return type.localeTitle;
  }

  String formatDateTime(int? epoch) {
    if (epoch == null || epoch <= 0) {
      return '-';
    }

    final formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  String formatDate(int? epoch) {
    if (epoch == null) return '--/--/--';
    return DateFormat('yyyy/MM/dd').format(DateTime.fromMillisecondsSinceEpoch(epoch));
  }

  String get getTotalPeopleLimitText {
    final num = getReservableItem?.totalPeopleLimit ?? 0;
    return num <= 0 ? '無限制' : num.toString();
  }

  String get getPerBookingPeopleLimitText {
    final num = getReservableItem?.perBookingPeopleLimit ?? 0;
    return num <= 0 ? '無限制' : num.toString();
  }

  String get getPaymentTypeText {
    final type = getReservableItem?.paymentType ?? EnumReservationPaymentType.free;
    return type.localeTitle;
  }

  String get getBillingMethodText {
    final unit = getReservableItem?.paymentType == EnumReservationPaymentType.points ? '點' : '元';
    final fee = getReservableItem?.fee ?? 0;
    return '$fee $unit/小時';
  }

  bool get isShowHourLimitText => (getReservableItem?.hourLimit ?? 0) > 0;

  String get getHourLimitText {
    final hours = getReservableItem?.hourLimit ?? 0;
    return hours <= 0 ? '無限制' : '$hours 小時';
  }

  /// 00:00 ～ 23:30，每半小時一檔（共 48 個）
  static List<String> get allTimeSlots => [
        for (var i = 0; i < 48; i++) '${(i ~/ 2).toString().padLeft(2, '0')}:${(i % 2 * 30).toString().padLeft(2, '0')}',
      ];

  /// 依目前選擇的日期與日期規則，回傳可選時間區段 [startMinutes, endMinutes]（含頭含尾，minute 為 0 或 30）。無限制或無日期時回傳 null 表示全天可選。
  ({int startMin, int endMin})? getAllowedTimeRangeMinutes() {
    final item = getReservableItem;
    if (item == null) return null;
    final ruleType = dateRuleType;
    final selectedDate = _model.date.value;

    if (ruleType == EnumReservationDateRuleType.unlimited) {
      final startAt = item.startAt;
      final endAt = item.endAt;
      if (startAt <= 0 || endAt <= 0) return null;
      final startDt = DateTime.fromMillisecondsSinceEpoch(startAt);
      final endDt = DateTime.fromMillisecondsSinceEpoch(endAt);
      final startMin = startDt.hour * 60 + startDt.minute;
      var endMin = endDt.hour * 60 + endDt.minute;
      if (endMin <= startMin) endMin += 24 * 60;
      return (startMin: startMin, endMin: endMin);
    }

    if (ruleType == EnumReservationDateRuleType.none) {
      if (selectedDate == null) return null;
      final dateStr = formatDate(selectedDate.millisecondsSinceEpoch);
      final matched = getSpecificDateList.where((d) => formatDate(d.bookingDate) == dateStr).toList();
      if (matched.isEmpty) return null;
      final d = matched.first;
      if (d.isAllDay == true) return null;
      final startMin = _parseTimeToMinutes(d.startTime ?? '00:00');
      final endMin = _parseTimeToMinutes(d.endTime ?? '23:30');
      return (startMin: startMin, endMin: endMin);
    }

    if (ruleType == EnumReservationDateRuleType.weekly) {
      if (selectedDate == null) return null;
      final day = selectedDate.weekday;
      final weekList = getEnableWeekDayList();
      final dayItem = weekList.where((e) => e.day == day).toList();
      if (dayItem.isEmpty) return null;
      final w = dayItem.first;
      if (w.isAllDay == true) return null;
      final periods = w.period ?? [];
      if (periods.isEmpty) return null;
      int rangeStart = 24 * 60;
      int rangeEnd = 0;
      for (final p in periods) {
        final s = _parseTimeToMinutes(p.startTime ?? '00:00');
        final e = _parseTimeToMinutes(p.endTime ?? '23:30');
        if (s < rangeStart) rangeStart = s;
        if (e > rangeEnd) rangeEnd = e;
      }
      return (startMin: rangeStart, endMin: rangeEnd);
    }

    return null;
  }

  int _parseTimeToMinutes(String timeStr) {
    final parts = timeStr.split(':');
    if (parts.length < 2) return 0;
    final h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    return h * 60 + m;
  }

  /// 開始時間可選項目（落在日期規則區段內）
  List<String> getStartTimeOptions() {
    final range = getAllowedTimeRangeMinutes();
    if (range == null) return allTimeSlots;
    final slots = <String>[];
    for (var i = 0; i < 48; i++) {
      final min = i * 30;
      if (min >= range.startMin && min < range.endMin) {
        slots.add(allTimeSlots[i]);
      }
    }
    return slots.isEmpty ? allTimeSlots : slots;
  }

  /// 結束時間可選項目（落在日期規則區段內、晚於已選開始時間，且不超過預約時長限制）
  List<String> getEndTimeOptions() {
    final range = getAllowedTimeRangeMinutes();
    final startMin = _model.startTime.value != null ? (_model.startTime.value!.hour * 60 + _model.startTime.value!.minute) : 0;
    final hourLimit = getReservableItem?.hourLimit ?? 0;
    final maxDurationMin = hourLimit > 0 ? hourLimit * 60 : 24 * 60;
    final maxEndMinByLimit = startMin + maxDurationMin;

    if (range == null) {
      if (startMin == 0 && _model.startTime.value == null) return allTimeSlots;
      return allTimeSlots.where((s) {
        final min = _parseTimeToMinutes(s);
        return min > startMin && min <= maxEndMinByLimit;
      }).toList();
    }
    final effectiveEndMin = maxEndMinByLimit < range.endMin ? maxEndMinByLimit : range.endMin;
    final slots = <String>[];
    for (var i = 0; i < 48; i++) {
      final min = i * 30;
      if (min > startMin && min <= effectiveEndMin) {
        slots.add(allTimeSlots[i]);
      }
    }
    return slots.isEmpty ? allTimeSlots : slots;
  }

  String? timeOfDayToSlot(TimeOfDay? t) {
    if (t == null) {
      return null;
    }
    var min = t.hour * 60 + t.minute;
    min = ((min + 15) ~/ 30) * 30;
    if (min >= 24 * 60) {
      min = 24 * 60 - 30;
    }
    return allTimeSlots[min ~/ 30];
  }

  TimeOfDay? slotToTimeOfDay(String? slot) {
    if (slot == null || slot.isEmpty) {
      return null;
    }
    final min = _parseTimeToMinutes(slot);
    return TimeOfDay(hour: min ~/ 60, minute: min % 60);
  }

  // MARK: - Private Methods

  void _checkTotalBillingText() {
    final unit = getReservableItem?.paymentType == EnumReservationPaymentType.points ? '點' : '元';
    final fee = getReservableItem?.fee ?? 0;
    final startTime = _model.startTime.value;
    final endTime = _model.endTime.value;

    if (!isReservableDetail) {
      final totalAmount = getRecordItem?.totalAmount ?? 0;
      _model.totalBilling.value = '$totalAmount $unit';
      _setTotalDurationFromEpoch(
        getRecordItem?.bookingStartAt,
        getRecordItem?.bookingEndAt,
      );
      return;
    }

    if (startTime == null || endTime == null) {
      _model.totalBilling.value = '-';
      _model.totalDuration.value = '-';
      return;
    }

    // 1. 計算總分鐘差（假設不跨夜）
    int startTotal = startTime.hour * 60 + startTime.minute;
    int endTotal = endTime.hour * 60 + endTime.minute;

    // 如果跨夜（例如 23:00 到 01:00），補足 24 小時
    int diffMinutes = endTotal - startTotal;

    if (diffMinutes < 0) {
      diffMinutes += 24 * 60;
    }

    // 2. 提取整數小時與剩餘分鐘
    int hours = diffMinutes ~/ 60;
    int remainingMinutes = diffMinutes % 60;

    // 3. 根據你的規則歸類
    double minuteValue = (remainingMinutes >= 30) ? 0.5 : 0.0;
    double hourResult = hours + minuteValue;

    _model.totalDuration.value = _formatDuration(hourResult);
    if (fee <= 0) {
      _model.totalBilling.value = '0 $unit';
    } else {
      _model.totalBilling.value = '${(hourResult * fee).toStringAsFixed(0)} $unit';
    }
  }

  void _setTotalDurationFromEpoch(int? startEpoch, int? endEpoch) {
    if (startEpoch == null || endEpoch == null || startEpoch <= 0 || endEpoch <= 0) {
      _model.totalDuration.value = '-';
      return;
    }
    final diffMs = endEpoch - startEpoch;
    final diffMinutes = diffMs ~/ (60 * 1000);
    final hours = diffMinutes ~/ 60;
    final remainingMinutes = diffMinutes % 60;
    final minuteValue = (remainingMinutes >= 30) ? 0.5 : 0.0;
    final hourResult = hours + minuteValue;
    _model.totalDuration.value = _formatDuration(hourResult);
  }

  String _formatDuration(double hourResult) {
    if (hourResult == hourResult.truncate()) {
      return '${hourResult.toInt()} 小時';
    }
    return '$hourResult 小時';
  }
}
