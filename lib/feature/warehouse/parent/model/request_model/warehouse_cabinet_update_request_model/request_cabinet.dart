import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_cabinet.freezed.dart';
part 'request_cabinet.g.dart';

@freezed
class RequestCabinet with _$RequestCabinet {
  factory RequestCabinet({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'new_cabinet_name') String? newRequestCabinetName,
    @JsonKey(name: 'new_room_id') String? newRoomId,
    @JsonKey(name: 'is_delete') bool? isDelete,
  }) = _RequestCabinet;

  factory RequestCabinet.fromJson(Map<String, dynamic> json) => _$RequestCabinetFromJson(json);
}
