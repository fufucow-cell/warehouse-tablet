import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemEditPositionWidgetModel {
  final isLoading = false.obs;
  String itemId = '';
  Item? combineItem;
  final changeRooms = Rx<List<WarehouseNameIdModel>>([]);
  final changeCabinets = Rx<List<WarehouseNameIdModel>>([]);
  final List<TextEditingController> quantityControllers = [];
  final List<DisplayPositionModel> positions = [];
}

class UpdatePositionModel {
  int index;
  WarehouseNameIdModel position;

  UpdatePositionModel({
    required this.index,
    required this.position,
  });
}

class DisplayPositionModel {
  int index;
  String? roomId;
  String roomName;
  String? cabinetId;
  String cabinetName;
  int quantity;
  bool isDelete = false;

  DisplayPositionModel({
    required this.index,
    this.roomId,
    required this.roomName,
    this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  });
}

class DialogItemEditPositionOutputModel {
  final String oldCabinetId;
  final String newCabinetId;
  final int moveQuantity;
  final bool isDelete;

  DialogItemEditPositionOutputModel({
    required this.oldCabinetId,
    required this.newCabinetId,
    required this.moveQuantity,
    required this.isDelete,
  });
}
