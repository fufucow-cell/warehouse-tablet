part of 'reservation_service.dart';

class ReservationServiceModel {
  final openItems = Rxn<List<ReservableItem>>();
  final recordItems = Rxn<List<RecordItem>>();
  BuildContext? nestedNavigatorContext;
}

class ReservableItemModel {
  final String name;
  final String reservationKey;
  final String categoryLv1Text;
  final String categoryLv2Text;
  final String categoryLv3Text;
  final String description;
  final String specification;
  final String notice;
  final int hourLimit;
  final int startAt;
  final int endAt;
  final int cancelTimeRange;
  final int perBookingPeopleLimit;
  final int totalPeopleLimit;
  final int fee;
  final EnumReservationPaymentType paymentType;
  final EnumReservationDateRuleType dateRuleType;
  final EnumReservationBookingLimitType bookingLimitType;
  final bool isPublished;
  final List<WeeklyRepeatResponseModel> weeklyRepeat;
  final List<SpecificDateResponseModel> specificDate;
  final List<String> imageUrls;

  const ReservableItemModel({
    required this.name,
    required this.reservationKey,
    required this.categoryLv1Text,
    required this.categoryLv2Text,
    required this.categoryLv3Text,
    required this.description,
    required this.specification,
    required this.notice,
    required this.hourLimit,
    required this.startAt,
    required this.endAt,
    required this.cancelTimeRange,
    required this.perBookingPeopleLimit,
    required this.totalPeopleLimit,
    required this.fee,
    required this.paymentType,
    required this.dateRuleType,
    required this.bookingLimitType,
    required this.isPublished,
    required this.weeklyRepeat,
    required this.specificDate,
    required this.imageUrls,
  });
}

class RecordUserInfoModel {
  final String id;
  final String name;
  final String phone;
  final String email;

  const RecordUserInfoModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });
}

class RecordCommunityInfoModel {
  final String communityId;
  final String communityName;
  final String householdId;
  final String householdName;
  final String address;

  const RecordCommunityInfoModel({
    required this.communityId,
    required this.communityName,
    required this.householdId,
    required this.householdName,
    required this.address,
  });
}

class RecordItemModel {
  final String id;
  final String orderId;
  final String controlKey;
  final int bookingStartAt;
  final int bookingEndAt;
  final int createdAt;
  final int updatedAt;
  final EnumOrderType orderType;
  final EnumTicketType ticketType;
  final EnumRecordPaymentType paymentType;
  final int totalAmount;
  final int ticketCreatedAt;
  final int paymentCreatedAt;
  final int adultCount;
  final int childCount;
  final ReservableItemModel itemReservableInfo;
  final RecordUserInfoModel userInfo;
  final RecordCommunityInfoModel communityInfo;

  const RecordItemModel({
    required this.id,
    required this.orderId,
    required this.controlKey,
    required this.bookingStartAt,
    required this.bookingEndAt,
    required this.createdAt,
    required this.updatedAt,
    required this.orderType,
    required this.ticketType,
    required this.paymentType,
    required this.totalAmount,
    required this.ticketCreatedAt,
    required this.paymentCreatedAt,
    required this.adultCount,
    required this.childCount,
    required this.itemReservableInfo,
    required this.userInfo,
    required this.communityInfo,
  });
}

enum EnumOrderType {
  all,
  progress,
  completed,
  cancelled;

  int get custIndex => switch (this) {
        all => -1,
        progress => 0,
        completed => 1,
        cancelled => 2,
      };

  /// UI tab index -> enum (titles uses `EnumOrderType.values`)
  static EnumOrderType fromIndex(int index) {
    if (index < 0 || index >= EnumOrderType.values.length) {
      return EnumOrderType.all;
    }
    return EnumOrderType.values[index];
  }

  /// API `order_type` value -> enum (0/1/2 corresponds to progress/completed/cancelled)
  static EnumOrderType fromCustIndex(int custIndex) {
    return switch (custIndex) {
      0 => EnumOrderType.progress,
      1 => EnumOrderType.completed,
      2 => EnumOrderType.cancelled,
      _ => EnumOrderType.all,
    };
  }

  String get localeTitle => switch (this) {
        all => '全部',
        progress => '進行中',
        completed => '已完成',
        cancelled => '已取消',
      };

  Color get color => switch (this) {
        all => EnumColor.textPrimary.color,
        progress => EnumColor.accentBlue.color,
        completed => EnumColor.accentGreen.color,
        cancelled => EnumColor.accentRed.color,
      };
}

enum EnumTicketType {
  unissued,
  issued;

  static EnumTicketType fromIndex(int index) {
    return switch (index) {
      0 => EnumTicketType.unissued,
      1 => EnumTicketType.issued,
      _ => EnumTicketType.unissued,
    };
  }

  String get localeTitle => switch (this) {
        unissued => '未開發票',
        issued => '已開發票',
      };
}

enum EnumRecordPaymentType {
  free,
  unpaid,
  paid;

  String get localeTitle => switch (this) {
        free => '免付款',
        unpaid => '未付款',
        paid => '已付款',
      };

  static EnumRecordPaymentType fromIndex(int? index) {
    if (index == null ||
        index < 0 ||
        index >= EnumRecordPaymentType.values.length) {
      return EnumRecordPaymentType.free;
    }

    return EnumRecordPaymentType.values[index];
  }
}

enum EnumReservationPaymentType {
  free,
  manual,
  points,
  bankTransfer,
  card;

  static EnumReservationPaymentType fromIndex(int index) {
    if (index < 0 || index >= EnumReservationPaymentType.values.length) {
      return EnumReservationPaymentType.free;
    }

    return EnumReservationPaymentType.values[index];
  }

  String get localeTitle => switch (this) {
        EnumReservationPaymentType.free => '免付費',
        EnumReservationPaymentType.manual => '人工收費',
        EnumReservationPaymentType.points => '點數折抵',
        EnumReservationPaymentType.bankTransfer => '線上轉帳',
        EnumReservationPaymentType.card => '線上刷卡',
      };
}

enum EnumReservationDateRuleType {
  unlimited,
  weekly,
  none;

  static EnumReservationDateRuleType fromIndex(int index) {
    if (index < 0 || index >= EnumReservationDateRuleType.values.length) {
      return EnumReservationDateRuleType.unlimited;
    }
    return EnumReservationDateRuleType.values[index];
  }

  String get localeTitle => switch (this) {
        EnumReservationDateRuleType.unlimited => '無限制',
        EnumReservationDateRuleType.weekly => '每週重複',
        EnumReservationDateRuleType.none => '特定日期',
      };
}

enum EnumReservationBookingLimitType {
  unlimited,
  single,
  multiple;

  static EnumReservationBookingLimitType fromIndex(int index) {
    if (index < 0 || index >= EnumReservationBookingLimitType.values.length) {
      return EnumReservationBookingLimitType.unlimited;
    }
    return EnumReservationBookingLimitType.values[index];
  }

  String get localeTitle => switch (this) {
        EnumReservationBookingLimitType.unlimited => '無限制',
        EnumReservationBookingLimitType.single => '同時段僅限單數預約',
        EnumReservationBookingLimitType.multiple => '同時段可多數預約',
      };
}
