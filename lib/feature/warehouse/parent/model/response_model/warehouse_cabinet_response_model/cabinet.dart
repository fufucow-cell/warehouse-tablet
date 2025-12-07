import 'package:freezed_annotation/freezed_annotation.dart';

part 'cabinet.freezed.dart';
part 'cabinet.g.dart';

@freezed
class Cabinet with _$Cabinet {
  factory Cabinet({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    @JsonKey(name: 'home_id') String? homeId,
    @JsonKey(name: 'room_id') String? roomId,
    String? name,
    @JsonKey(name: 'room_name') String? roomName,
    String? description,
  }) = _Cabinet;

  factory Cabinet.fromJson(Map<String, dynamic> json) =>
      _$CabinetFromJson(json);
}
