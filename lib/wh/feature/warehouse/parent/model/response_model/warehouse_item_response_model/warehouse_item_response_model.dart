import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/room.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'warehouse_item_response_model.freezed.dart';
part 'warehouse_item_response_model.g.dart';

@freezed
class WarehouseItemResponseModel with _$WarehouseItemResponseModel {
  factory WarehouseItemResponseModel({
    int? code,
    String? message,
    List<Room>? data,
  }) = _WarehouseItemResponseModel;

  factory WarehouseItemResponseModel.fromJson(Map<String, dynamic> json) => _$WarehouseItemResponseModelFromJson(json);
}
