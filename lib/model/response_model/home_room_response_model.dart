import 'package:json_annotation/json_annotation.dart';

part 'home_room_response_model.g.dart';

@JsonSerializable()
class HomeRoomResponseModel {
  @JsonKey(name: 'room_id')
  int? roomId;
  @JsonKey(name: 'home_id')
  int? homeId;
  @JsonKey(name: 'room_name')
  String? roomName;

  HomeRoomResponseModel({this.roomId, this.homeId, this.roomName});

  factory HomeRoomResponseModel.fromJson(Map<String, dynamic> json) {
    return _$HomeRoomResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeRoomResponseModelToJson(this);
}
