import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  factory Room({
    @JsonKey(name: 'room_id') String? roomId,
    @JsonKey(name: 'home_id') String? homeId,
    @JsonKey(name: 'room_name') String? roomName,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
