import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_position.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/item_quantity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_record.freezed.dart';
part 'item_record.g.dart';

@freezed
class ItemRecord with _$ItemRecord {
  factory ItemRecord({
    String? id,
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'entity_type') int? entityType,
    @JsonKey(name: 'item_name') List<String>? itemName,
    @JsonKey(name: 'item_description') List<String>? itemDescription,
    @JsonKey(name: 'item_photo') List<String>? itemPhoto,
    @JsonKey(name: 'item_min_stock_count') List<int>? itemMinStockCount,
    @JsonKey(name: 'category_name') List<String>? categoryName,
    @JsonKey(name: 'cabinet_name') List<String>? cabinetName,
    @JsonKey(name: 'cabinet_room_name') List<String>? cabinetRoomName,
    @JsonKey(name: 'item_position') List<ItemPosition>? itemPosition,
    @JsonKey(name: 'item_quantity') ItemQuantity? itemQuantity,
  }) = _ItemRecord;

  factory ItemRecord.fromJson(Map<String, dynamic> json) =>
      _$ItemRecordFromJson(json);
}
