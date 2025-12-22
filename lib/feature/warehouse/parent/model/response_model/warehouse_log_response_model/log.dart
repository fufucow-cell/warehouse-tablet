import 'package:freezed_annotation/freezed_annotation.dart';

part 'log.freezed.dart';
part 'log.g.dart';

@freezed
class Log with _$Log {
  factory Log({
    String? id,
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'entity_type') int? entityType,
    @JsonKey(name: 'record_type') int? recordType,
    @JsonKey(name: 'item_name') List<String?>? itemName,
    @JsonKey(name: 'item_description') List<String?>? itemDescription,
    @JsonKey(name: 'item_photo') List<String?>? itemPhoto,
    @JsonKey(name: 'item_min_stock_count') List<int?>? itemMinStockCount,
    @JsonKey(name: 'item_quantity') ItemQuantity? itemQuantity,
    @JsonKey(name: 'item_position') ItemPosition? itemPosition,
    @JsonKey(name: 'cabinet_room_name') List<String?>? cabinetRoomName,
    @JsonKey(name: 'cabinet_name') List<String?>? cabinetName,
    @JsonKey(name: 'category_name') List<String?>? categoryName,
  }) = _Log;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
}

@freezed
class ItemQuantity with _$ItemQuantity {
  factory ItemQuantity({
    @JsonKey(name: 'total_count') List<int?>? totalCount,
    List<ItemQuantityCabinet>? cabinets,
  }) = _ItemQuantity;

  factory ItemQuantity.fromJson(Map<String, dynamic> json) => _$ItemQuantityFromJson(json);
}

@freezed
class ItemQuantityCabinet with _$ItemQuantityCabinet {
  factory ItemQuantityCabinet({
    @JsonKey(name: 'cabinet_name') String? cabinetName,
    List<int?>? count,
  }) = _ItemQuantityCabinet;

  factory ItemQuantityCabinet.fromJson(Map<String, dynamic> json) => _$ItemQuantityCabinetFromJson(json);
}

@freezed
class ItemPosition with _$ItemPosition {
  factory ItemPosition({
    List<ItemPositionCabinet>? cabinets,
  }) = _ItemPosition;

  factory ItemPosition.fromJson(Map<String, dynamic> json) => _$ItemPositionFromJson(json);
}

@freezed
class ItemPositionCabinet with _$ItemPositionCabinet {
  factory ItemPositionCabinet({
    @JsonKey(name: 'cabinet_name') List<String?>? cabinetName,
    int? count,
  }) = _ItemPositionCabinet;

  factory ItemPositionCabinet.fromJson(Map<String, dynamic> json) => _$ItemPositionCabinetFromJson(json);
}
