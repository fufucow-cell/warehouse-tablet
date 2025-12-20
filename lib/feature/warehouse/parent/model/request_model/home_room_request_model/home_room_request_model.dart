import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_room_request_model.freezed.dart';
part 'home_room_request_model.g.dart';

@freezed
class HomeRoomRequestModel with _$HomeRoomRequestModel {
  factory HomeRoomRequestModel({
    @JsonKey(name: 'household_id') String? homeId,
    @JsonKey(name: 'room_id') String? roomId,
  }) = _HomeRoomRequestModel;

  factory HomeRoomRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HomeRoomRequestModelFromJson(json);
}
