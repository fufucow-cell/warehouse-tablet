import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:get/get.dart';

class DialogCabinetEditWidgetModel {
  final isLoading = false.obs;
  Cabinet? cabinet;
  final selectedRoomId = Rxn<String>();
}

class DialogCabinetEditOutputModel {
  String name;
  String roomId;

  DialogCabinetEditOutputModel({
    required this.name,
    required this.roomId,
  });
}
