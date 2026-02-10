import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/service/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogItemEditPositionWidgetModel {
  final isLoading = false.obs;
  String itemId = '';
  Item? combineItem;
  final changePositions = Rx<List<NewPositionModel>>([]);
  final List<TextEditingController> quantityControllers = [];
  final List<DisplayPositionModel> positions = [];
}

class NewPositionModel {
  WarehouseNameIdModel room;
  WarehouseNameIdModel cabinet;

  NewPositionModel({
    required this.room,
    required this.cabinet,
  });
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
