part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageModel {
  List<Log>? alarmLogs;
  List<Log>? allAlarmLogs; // 保存所有原始告警日志数据
  final isEditMode = false.obs;
  final selectedLogIds = <String>{}.obs;
  DateTime? startDate;
  DateTime? endDate;
}
