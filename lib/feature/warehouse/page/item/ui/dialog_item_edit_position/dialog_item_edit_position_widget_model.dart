import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/service/warehouse_service.dart';
import 'package:get/get.dart';

class DialogItemEditPositionWidgetModel {
  String itemId = '';
  Item? combineItem;
  final changeRooms = Rx<List<WarehouseNameIdModel>>([]);
  final changeCabinets = Rx<List<WarehouseNameIdModel>>([]);
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
  final TextEditingController textEditingController;

  DisplayPositionModel({
    required this.index,
    this.roomId,
    required this.roomName,
    this.cabinetId,
    required this.cabinetName,
    required this.quantity,
  }) : textEditingController = TextEditingController(text: '0');
}
