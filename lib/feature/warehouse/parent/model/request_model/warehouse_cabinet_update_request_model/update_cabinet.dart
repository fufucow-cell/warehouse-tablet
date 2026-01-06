import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_cabinet.freezed.dart';
part 'update_cabinet.g.dart';

@freezed
class UpdateCabinet with _$UpdateCabinet {
  factory UpdateCabinet({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'new_cabinet_name') String? newCabinetName,
    @JsonKey(name: 'new_room_id') String? newRoomId,
    @JsonKey(name: 'old_room_name') String? oldRoomName,
    @JsonKey(name: 'new_room_name') String? newRoomName,
  }) = _UpdateCabinet;

  factory UpdateCabinet.fromJson(Map<String, dynamic> json) => _$UpdateCabinetFromJson(json);
}
