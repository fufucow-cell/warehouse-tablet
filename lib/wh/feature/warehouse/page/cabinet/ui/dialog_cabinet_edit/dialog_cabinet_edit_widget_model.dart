import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogCabinetEditWidgetModel {
  final isLoading = false.obs;
  RoomCabinetInfo? room;
  final editModels = Rx<List<EditModel>>([]);
}

class EditModel {
  WarehouseNameIdModel oldCabinet;
  String? newCabinetName;
  WarehouseNameIdModel? newRoom;
  bool isDelete = false;
  bool isExpanded = false;
  TextEditingController textController;

  EditModel({
    required this.oldCabinet,
    required this.textController,
    this.newCabinetName,
    this.newRoom,
  });
}

class ChangeRoomModel {
  EditModel editModel;
  String? newRoomName;

  ChangeRoomModel({
    required this.editModel,
    this.newRoomName,
  });
}

class DialogCabinetEditOutputModel {
  String cabinetId;
  bool isDelete;
  String? newRoomName;
  String? newRoomId;
  String? newCabinetName;

  DialogCabinetEditOutputModel({
    required this.cabinetId,
    required this.isDelete,
    required this.newRoomName,
    required this.newRoomId,
    required this.newCabinetName,
  });
}
