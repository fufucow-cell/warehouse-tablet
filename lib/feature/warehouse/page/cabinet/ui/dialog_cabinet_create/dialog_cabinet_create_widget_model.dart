import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogCabinetCreateWidgetModel {
  final isLoading = false.obs;
  final selectedRoom = Rxn<WarehouseNameIdModel?>();
}

class DialogCabinetCreateOutputModel {
  String name;
  String? roomId;
  String? roomName;

  DialogCabinetCreateOutputModel({
    required this.name,
    this.roomId,
    this.roomName,
  });
}
