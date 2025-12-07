import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  factory Room({
    @JsonKey(name: 'room_id') String? roomId,
    @JsonKey(name: 'room_name') String? roomName,
    int? quantity,
    List<Cabinet>? cabinets,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
