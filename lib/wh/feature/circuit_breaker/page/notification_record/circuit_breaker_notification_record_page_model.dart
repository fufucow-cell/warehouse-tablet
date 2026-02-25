import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:get/get.dart';

class CircuitBreakerNotificationRecordPageModel {
  CircuitBreakerNotificationRecordPageRouterData? routerData;
  final selectedTab = EnumRecordType.power.obs;
  final currentRecords = Rxn<Map<String, List<RecordModel>>>();
}

class CircuitBreakerNotificationRecordPageRouterData {
  final Future<List<RecordModel>> Function(EnumRecordType type)? onTabChanged;

  const CircuitBreakerNotificationRecordPageRouterData({
    this.onTabChanged,
  });
}

enum EnumRecordType {
  power,
  alert,
  notification;

  String get title => switch (this) {
        EnumRecordType.power => EnumLocale.engoSwitchRecord.tr,
        EnumRecordType.alert => EnumLocale.engoAlertRecord.tr,
        EnumRecordType.notification => EnumLocale.engoNotificationRecord.tr,
      };

  static EnumRecordType fromString(String value) {
    return EnumRecordType.values.firstWhereOrNull((e) => e.title == value) ?? EnumRecordType.power;
  }
}

/// 记录数据模型（用于所有三个 tab）
class RecordModel {
  final DateTime date;
  final String content;

  const RecordModel({
    required this.date,
    required this.content,
  });
}
