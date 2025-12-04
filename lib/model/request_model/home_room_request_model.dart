import 'package:json_annotation/json_annotation.dart';

part 'home_room_request_model.g.dart';

@JsonSerializable()
class HomeRoomRequestModel {
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'room_id')
  int? roomId;
  @JsonKey(name: 'room_name')
  String? roomName;

  HomeRoomRequestModel({this.homeId, this.roomId, this.roomName});

  factory HomeRoomRequestModel.fromJson(Map<String, dynamic> json) {
    return _$HomeRoomRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeRoomRequestModelToJson(this);
}
