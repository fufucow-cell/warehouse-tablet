part of 'reservation_detail_page_controller.dart';

enum EnumReservationDetailPageInteractive {
  tapBack,
  tapImage,
  tapConfirm,
  dateChanged,
  startTimeChanged,
  endTimeChanged,
  tapInfoTabItem,
}

extension ReservationDetailPageUserEventExtension
    on ReservationDetailPageController {
  Future<void> interactive(EnumReservationDetailPageInteractive type,
      {dynamic data}) async {
    switch (type) {
      case EnumReservationDetailPageInteractive.tapBack:
        await _routerHandle(EnumReservationDetailPageRoute.goBack);
      case EnumReservationDetailPageInteractive.tapImage:
        await _routerHandle(EnumReservationDetailPageRoute.openImageViewer,
            data: data);
      case EnumReservationDetailPageInteractive.tapConfirm:
        break;
      case EnumReservationDetailPageInteractive.dateChanged:
        if (data is DateTime) {
          _model.date.value = data;
        } else if (data is String) {
          _model.selectedDate.value = data;
          final ruleType = dateRuleType;
          if (ruleType == EnumReservationDateRuleType.none) {
            final matched = getSpecificDateList
                .where((d) => formatDate(d.bookingDate) == data)
                .toList();
            if (matched.isNotEmpty) {
              final epoch = matched.first.bookingDate;
              if (epoch != null) {
                _model.date.value =
                    DateTime.fromMillisecondsSinceEpoch(epoch);
              }
            }
          } else if (ruleType == EnumReservationDateRuleType.weekly) {
            const labels = ['', '週一', '週二', '週三', '週四', '週五', '週六', '週日'];
            final day = labels.indexOf(data);
            if (day >= 1 && day <= 7) {
              final resolved = getFirstDateForWeekday(day);
              if (resolved != null) _model.date.value = resolved;
            }
          }
        }
      case EnumReservationDetailPageInteractive.startTimeChanged:
        _model.endTime.value = null;
        if (data is TimeOfDay) {
          _model.startTime.value = data;
          _checkTotalBillingText();
        } else if (data is String) {
          final t = slotToTimeOfDay(data);
          if (t != null) {
            _model.startTime.value = t;
            _checkTotalBillingText();
          }
        }
      case EnumReservationDetailPageInteractive.endTimeChanged:
        if (data is TimeOfDay) {
          _model.endTime.value = data;
          _checkTotalBillingText();
        } else if (data is String) {
          final t = slotToTimeOfDay(data);
          if (t != null) {
            _model.endTime.value = t;
            _checkTotalBillingText();
          }
        }
      case EnumReservationDetailPageInteractive.tapInfoTabItem:
        if (data is int) {
          _model.infoTabType.value = EnumReservationInfoTabType.fromIndex(data);
        }
    }
  }
}
