import 'package:get/get.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/model/reservation_item_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';

part 'reservation_main_page_interactive.dart';
part 'reservation_main_page_route.dart';

class ReservationMainPageController extends GetxController {
  // MARK: - Properties

  final _model = ReservationMainPageModel();
  final ReservationService _service = ReservationService.instance;

  // MARK: - Init

  ReservationMainPageController();

  @override
  void onInit() {
    super.onInit();
    _interactive(EnumReservationMainPageInteractive.loadItems);
  }

  // MARK: - Methods

  bool get isLoading {
    return _model.isLoading;
  }

  String? get errorMessage {
    return _model.errorMessage;
  }

  List<ReservationItemModel> get items {
    return _model.items;
  }

  ReservationItemModel? get selectedItem {
    final String? selectedId = _model.selectedItemId;
    if (selectedId == null || selectedId.isEmpty) {
      return null;
    }
    for (final ReservationItemModel item in _model.items) {
      if (item.id == selectedId) {
        return item;
      }
    }
    return null;
  }

  int get selectedInfoTabIndex {
    return _model.selectedInfoTabIndex;
  }

  String get selectedDateOption {
    return _model.selectedDateOption;
  }

  String get selectedStartTime {
    return _model.selectedStartTime;
  }

  String get selectedEndTime {
    return _model.selectedEndTime;
  }

  String get selectedPeople {
    return _model.selectedPeople;
  }

  List<String> get dateOptions {
    final ReservationItemModel? item = selectedItem;
    if (item == null) {
      return const <String>[];
    }
    return item
        .buildAvailableDates(maxDays: 45)
        .map((DateTime date) => _dateToIso(date))
        .toList();
  }

  List<String> get timeOptions {
    final ReservationItemModel? item = selectedItem;
    final DateTime? date = _safeParseIso(_model.selectedDateOption);
    if (item == null || date == null) {
      return const <String>[];
    }
    final List<ReservationTimeSlot> slots = item.buildSlotsForDate(date);
    final Set<String> options = <String>{};
    for (final ReservationTimeSlot slot in slots) {
      options.add(slot.start);
      options.add(slot.end);
    }
    if (options.isEmpty) {
      return const <String>[];
    }
    final List<String> sorted = options.toList();
    sorted.sort();
    return sorted;
  }

  List<String> get peopleOptions {
    return const <String>[
      '1位成人 / 0位孩童',
      '2位成人 / 0位孩童',
      '2位成人 / 1位孩童',
      '3位成人 / 0位孩童',
    ];
  }

  void selectItem(String itemId) {
    _model.selectedItemId = itemId;
    _resetBookingSelectionForCurrentItem();
    update();
  }

  void setInfoTabIndex(int index) {
    _model.selectedInfoTabIndex = index;
    update();
  }

  void setDateOption(String value) {
    _model.selectedDateOption = value;
    final List<String> times = timeOptions;
    if (!times.contains(_model.selectedStartTime)) {
      _model.selectedStartTime = times.isNotEmpty ? times.first : '';
    }
    if (!times.contains(_model.selectedEndTime)) {
      if (times.length >= 2) {
        _model.selectedEndTime = times[1];
      } else {
        _model.selectedEndTime = times.isNotEmpty ? times.first : '';
      }
    }
    update();
  }

  void setStartTime(String value) {
    _model.selectedStartTime = value;
    final List<String> times = timeOptions;
    if (times.contains(_model.selectedEndTime) && _model.selectedEndTime.compareTo(value) > 0) {
      update();
      return;
    }
    final int index = times.indexOf(value);
    if (index >= 0 && index + 1 < times.length) {
      _model.selectedEndTime = times[index + 1];
    }
    update();
  }

  void setEndTime(String value) {
    _model.selectedEndTime = value;
    update();
  }

  void setPeopleOption(String value) {
    _model.selectedPeople = value;
    update();
  }

  int get totalHours {
    int toMinute(String value) {
      final List<String> split = value.split(':');
      if (split.length != 2) {
        return 0;
      }
      final int hour = int.tryParse(split[0]) ?? 0;
      final int minute = int.tryParse(split[1]) ?? 0;
      return hour * 60 + minute;
    }

    final int startMinute = toMinute(_model.selectedStartTime);
    final int endMinute = toMinute(_model.selectedEndTime);
    if (endMinute <= startMinute) {
      return 1;
    }
    final int diff = endMinute - startMinute;
    return (diff / 60).ceil();
  }

  int get totalPrice {
    final int unitPrice = selectedItem?.unitPrice ?? 0;
    return unitPrice * totalHours;
  }

  Future<void> refreshItems() async {
    await _interactive(EnumReservationMainPageInteractive.loadItems);
  }

  Future<void> reserveItem(ReservationItemModel item) async {
    await _interactive(
      EnumReservationMainPageInteractive.tapReserve,
      data: item,
    );
  }

  Future<void> loadItems() async {
    _model.isLoading = true;
    _model.errorMessage = null;
    update();

    try {
      final List<ReservationItemModel> result = await _service.fetchOpenItems();
      _model.items = result;
      if (_model.items.isNotEmpty) {
        final bool selectedStillExists = _model.items.any((ReservationItemModel e) => e.id == _model.selectedItemId);
        if (!selectedStillExists) {
          _model.selectedItemId = _model.items.first.id;
        }
        _resetBookingSelectionForCurrentItem();
      } else {
        _model.selectedItemId = null;
        _model.selectedDateOption = '';
        _model.selectedStartTime = '';
        _model.selectedEndTime = '';
      }
    } on Object catch (error) {
      _model.errorMessage = '讀取預約項目失敗: $error';
      _model.items = <ReservationItemModel>[];
      _model.selectedItemId = null;
      _model.selectedDateOption = '';
      _model.selectedStartTime = '';
      _model.selectedEndTime = '';
    } finally {
      _model.isLoading = false;
      update();
    }
  }

  Future<String> submitBooking() async {
    final ReservationItemModel? item = selectedItem;
    if (item == null) {
      throw Exception('尚未選擇預約項目');
    }
    final DateTime? selectedDate = _safeParseIso(_model.selectedDateOption);
    if (selectedDate == null) {
      throw Exception('尚未選擇日期');
    }
    if (_model.selectedStartTime.isEmpty || _model.selectedEndTime.isEmpty) {
      throw Exception('尚未選擇時段');
    }

    final int? startMs = _toEpochMs(selectedDate, _model.selectedStartTime);
    final int? endMs = _toEpochMs(selectedDate, _model.selectedEndTime);
    if (startMs == null || endMs == null || endMs <= startMs) {
      throw Exception('時段選擇不正確');
    }

    final int peopleCount = _extractPeopleCount(_model.selectedPeople);
    return _service.createBookingOrder(
      itemId: item.id,
      bookingStartAt: startMs,
      bookingEndAt: endMs,
      peopleCount: peopleCount,
      userName: 'App User',
      userPhone: '0912345678',
      note: '',
    );
  }

  void _resetBookingSelectionForCurrentItem() {
    final List<String> dates = dateOptions;
    _model.selectedDateOption = dates.isNotEmpty ? dates.first : '';

    final List<String> times = timeOptions;
    if (times.length >= 2) {
      _model.selectedStartTime = times.first;
      _model.selectedEndTime = times[1];
    } else if (times.length == 1) {
      _model.selectedStartTime = times.first;
      _model.selectedEndTime = times.first;
    } else {
      _model.selectedStartTime = '';
      _model.selectedEndTime = '';
    }
  }

  String _dateToIso(DateTime date) {
    final String y = date.year.toString().padLeft(4, '0');
    final String m = date.month.toString().padLeft(2, '0');
    final String d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  DateTime? _safeParseIso(String iso) {
    final String value = iso.trim();
    if (value.isEmpty) {
      return null;
    }
    return DateTime.tryParse(value);
  }

  int _extractPeopleCount(String text) {
    final RegExp digitReg = RegExp(r'(\d+)位成人');
    final Match? match = digitReg.firstMatch(text);
    return int.tryParse(match?.group(1) ?? '1') ?? 1;
  }

  int? _toEpochMs(DateTime date, String hhmm) {
    final List<String> split = hhmm.split(':');
    if (split.length != 2) {
      return null;
    }
    final int? hour = int.tryParse(split[0]);
    final int? minute = int.tryParse(split[1]);
    if (hour == null || minute == null) {
      return null;
    }
    final DateTime local = DateTime(date.year, date.month, date.day, hour, minute);
    return local.millisecondsSinceEpoch;
  }
}