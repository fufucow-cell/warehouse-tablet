import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/category.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  factory Item({
    String? id,
    String? name,
    String? description,
    int? quantity,
    @JsonKey(name: 'min_stock_alert') int? minStockAlert,
    dynamic photo,
    Category? category,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
