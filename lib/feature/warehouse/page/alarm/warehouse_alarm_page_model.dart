part of 'warehouse_alarm_page.dart';

class WarehouseAlarmPageModel {
  final allRoomCabinetItems = Rxn<List<Room>>();
  final visibleItems = Rx<List<Item>>([]);
  final columnRatio = [170, 705, 280, 280];
}
