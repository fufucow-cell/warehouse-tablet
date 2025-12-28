import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:get/get.dart';

class DialogCabinetDeleteWidgetModel {
  final isLoading = false.obs;
  Cabinet? cabinet;
}

class DialogCabinetDeleteOutputModel {
  String cabinetId;

  DialogCabinetDeleteOutputModel({
    required this.cabinetId,
  });
}
