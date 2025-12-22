import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_position.freezed.dart';
part 'item_position.g.dart';

@freezed
class ItemPosition with _$ItemPosition {
  factory ItemPosition({
    @JsonKey(name: 'cabinet_name') List<String>? cabinetName,
    int? count,
  }) = _ItemPosition;

  factory ItemPosition.fromJson(Map<String, dynamic> json) => _$ItemPositionFromJson(json);
}
