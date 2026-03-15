import 'package:engo_terminal_app3/wh/feature/reservation/page/detail/reservation_detail_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/ui/image_viewer.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/period.dart';
import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/weekly_repeat_response_model.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_rx.dart';
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
  RxReadonly<TimeOfDay?> get startTimeRx => _model.startTime.readonly;
  RxReadonly<TimeOfDay?> get endTimeRx => _model.endTime.readonly;
  RxReadonly<String> get totalBillingRx => _model.totalBilling.readonly;
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

  // MARK: - Private Methods

  void _checkTotalBillingText() {
    final unit = getReservableItem?.paymentType == EnumReservationPaymentType.points ? '點' : '元';
    final fee = getReservableItem?.fee ?? 0;
    final startTime = _model.startTime.value;
    final endTime = _model.endTime.value;

    if (!isReservableDetail) {
      final totalAmount = getRecordItem?.totalAmount ?? 0;
      _model.totalBilling.value = '$totalAmount $unit';
      return;
    }

    if (startTime == null || endTime == null || fee <= 0) {
      _model.totalBilling.value = '-';
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

    _model.totalBilling.value = '${(hourResult * fee).toStringAsFixed(0)} $unit';
  }
}
