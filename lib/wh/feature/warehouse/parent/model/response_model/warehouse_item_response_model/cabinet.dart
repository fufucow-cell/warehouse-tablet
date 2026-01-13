import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cabinet.freezed.dart';
part 'cabinet.g.dart';

@freezed
class Cabinet with _$Cabinet {
  factory Cabinet({
    String? id,
    String? name,
    int? quantity,
    List<Item>? items,
  }) = _Cabinet;

  factory Cabinet.fromJson(Map<String, dynamic> json) => _$CabinetFromJson(json);
}
