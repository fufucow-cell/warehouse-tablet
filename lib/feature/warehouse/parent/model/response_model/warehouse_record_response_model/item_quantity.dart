import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_record_response_model/cabinet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_quantity.freezed.dart';
part 'item_quantity.g.dart';

@freezed
class ItemQuantity with _$ItemQuantity {
  factory ItemQuantity({
    @JsonKey(name: 'total_count') List<int>? totalCount,
    List<Cabinet>? cabinets,
  }) = _ItemQuantity;

  factory ItemQuantity.fromJson(Map<String, dynamic> json) =>
      _$ItemQuantityFromJson(json);
}
