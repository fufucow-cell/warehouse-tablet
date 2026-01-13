import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  factory Room({
    @JsonKey(name: 'room_id') String? roomId,
    int? quantity,
    List<Cabinet>? cabinets,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
