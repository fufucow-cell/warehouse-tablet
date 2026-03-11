class ReservationItemModel {
  final String id;
  final String name;
  final String category;
  final bool isPublished;
  final Map<String, dynamic> data;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ReservationItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.isPublished,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReservationItemModel.fromJson(Map<String, dynamic> json) {
    return ReservationItemModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      isPublished: json['isPublished'] == true,
      data: (json['data'] is Map<String, dynamic>) ? json['data'] as Map<String, dynamic> : <String, dynamic>{},
      createdAt: _tryParseDateTime(json['createdAt']),
      updatedAt: _tryParseDateTime(json['updatedAt']),
    );
  }

  String get reservationKey {
    return (data['community'] ?? '').toString();
  }

  List<String> get imageUrls {
    final dynamic raw = data['imageUrls'];
    if (raw is! List) {
      return <String>[];
    }
    return raw.map((dynamic e) => e.toString()).where((String e) => e.isNotEmpty).toList();
  }

  String get categoryText {
    final String lv1 = (data['locationLv1'] ?? '').toString().trim();
    final String lv2 = (data['locationLv2'] ?? '').toString().trim();
    final String lv3 = (data['locationLv3'] ?? '').toString().trim();
    final List<String> parts = <String>[lv1, lv2, lv3].where((String value) => value.isNotEmpty).toList();
    return parts.join(' / ');
  }

  String get descriptionText {
    return (data['description'] ?? '').toString();
  }

  String get specificationText {
    return (data['specification'] ?? '').toString();
  }

  String get noticeText {
    return (data['notice'] ?? '').toString();
  }

  int get unitPrice {
    final dynamic value = data['unitPrice'];
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value.toString()) ?? 0;
  }

  int get totalPeopleLimit {
    final dynamic value = data['totalPeopleLimit'];
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value.toString()) ?? 0;
  }

  String get bookingOpenAt {
    return (data['bookingOpenAt'] ?? '').toString();
  }

  String get bookingCloseAt {
    return (data['bookingCloseAt'] ?? '').toString();
  }

  String get repeatMode {
    return (data['repeatMode'] ?? '').toString();
  }

  List<ReservationTimeSlot> buildSlotsForDate(DateTime date) {
    final String mode = repeatMode;
    if (mode == 'weekly') {
      return _weeklySlotsForDate(date);
    }
    if (mode == 'date') {
      return _specificDateSlotsForDate(date);
    }
    return <ReservationTimeSlot>[
      const ReservationTimeSlot(
        start: '00:00',
        end: '23:59',
        allDay: true,
      ),
    ];
  }

  List<DateTime> buildAvailableDates({int maxDays = 30}) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final String mode = repeatMode;

    if (mode == 'date') {
      final List<DateTime> dates = <DateTime>[];
      final dynamic raw = data['specificDateSlots'];
      if (raw is! List) {
        return <DateTime>[today];
      }
      for (final dynamic row in raw) {
        if (row is! Map<String, dynamic>) {
          continue;
        }
        final String iso = (row['dateIso'] ?? '').toString().trim();
        if (iso.isEmpty) {
          continue;
        }
        final DateTime? parsed = DateTime.tryParse(iso);
        if (parsed == null) {
          continue;
        }
        final DateTime dateOnly = DateTime(parsed.year, parsed.month, parsed.day);
        if (dateOnly.isBefore(today)) {
          continue;
        }
        dates.add(dateOnly);
      }
      dates.sort();
      if (dates.isEmpty) {
        return <DateTime>[today];
      }
      return dates;
    }

    if (mode == 'weekly') {
      final List<DateTime> dates = <DateTime>[];
      for (int i = 0; i < maxDays; i++) {
        final DateTime date = today.add(Duration(days: i));
        final List<ReservationTimeSlot> slots = _weeklySlotsForDate(date);
        if (slots.isNotEmpty) {
          dates.add(date);
        }
      }
      if (dates.isEmpty) {
        return <DateTime>[today];
      }
      return dates;
    }

    return <DateTime>[today];
  }

  String get dateRuleLabel {
    final value = (data['repeatMode'] ?? '').toString();
    switch (value) {
      case 'none':
        return '無限制';
      case 'weekly':
        return '每週重複';
      case 'date':
        return '指定日期';
      default:
        return '未設定';
    }
  }

  String get priceLabel {
    final paymentMethod = (data['paymentMethod'] ?? '').toString();
    if (paymentMethod == 'free') {
      return '免付費';
    }
    final fee = (data['unitPrice'] ?? 0).toString();
    return '付費 $fee';
  }

  static DateTime? _tryParseDateTime(dynamic value) {
    if (value == null) {
      return null;
    }
    final text = value.toString().trim();
    if (text.isEmpty) {
      return null;
    }
    return DateTime.tryParse(text);
  }

  List<ReservationTimeSlot> _weeklySlotsForDate(DateTime date) {
    final dynamic raw = data['weeklySlots'];
    if (raw is! List) {
      return <ReservationTimeSlot>[];
    }
    const Map<int, String> weekdayMap = <int, String>{
      DateTime.monday: 'mon',
      DateTime.tuesday: 'tue',
      DateTime.wednesday: 'wed',
      DateTime.thursday: 'thu',
      DateTime.friday: 'fri',
      DateTime.saturday: 'sat',
      DateTime.sunday: 'sun',
    };
    final String dayKey = weekdayMap[date.weekday] ?? '';
    final List<ReservationTimeSlot> slots = <ReservationTimeSlot>[];

    for (final dynamic row in raw) {
      if (row is! Map<String, dynamic>) {
        continue;
      }
      final String rowDay = (row['day'] ?? '').toString().trim();
      final bool enabled = row['enabled'] == true;
      if (rowDay != dayKey || !enabled) {
        continue;
      }
      slots.add(
        ReservationTimeSlot(
          start: (row['start'] ?? '09:00').toString(),
          end: (row['end'] ?? '17:00').toString(),
          allDay: row['allDay'] == true,
        ),
      );
    }
    return slots;
  }

  List<ReservationTimeSlot> _specificDateSlotsForDate(DateTime date) {
    final dynamic raw = data['specificDateSlots'];
    if (raw is! List) {
      return <ReservationTimeSlot>[];
    }
    final String target = '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final List<ReservationTimeSlot> slots = <ReservationTimeSlot>[];
    for (final dynamic row in raw) {
      if (row is! Map<String, dynamic>) {
        continue;
      }
      final String iso = (row['dateIso'] ?? '').toString().trim();
      if (iso != target) {
        continue;
      }
      slots.add(
        ReservationTimeSlot(
          start: (row['start'] ?? '09:00').toString(),
          end: (row['end'] ?? '17:00').toString(),
          allDay: row['allDay'] == true,
        ),
      );
    }
    return slots;
  }
}

class ReservationTimeSlot {
  final String start;
  final String end;
  final bool allDay;

  const ReservationTimeSlot({
    required this.start,
    required this.end,
    required this.allDay,
  });
}
