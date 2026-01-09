import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_cabinet.freezed.dart';
part 'delete_cabinet.g.dart';

@freezed
class DeleteCabinet with _$DeleteCabinet {
  factory DeleteCabinet({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'old_room_name') String? oldRoomName,
  }) = _DeleteCabinet;

  factory DeleteCabinet.fromJson(Map<String, dynamic> json) =>
      _$DeleteCabinetFromJson(json);
}
