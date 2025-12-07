part of 'warehouse_cabinet_page.dart';

class WarehouseCabinetPageModel {
  List<Cabinet>? cabinets;
  List<Cabinet>? allCabinets; // 保存所有原始櫥櫃数据
  final isEditMode = false.obs;
  String? filterName;
  String? filterRoomId;
}
