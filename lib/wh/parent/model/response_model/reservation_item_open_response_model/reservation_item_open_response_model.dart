import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_open_response_model/datum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_item_open_response_model.freezed.dart';
part 'reservation_item_open_response_model.g.dart';

@freezed
class ReservationItemOpenResponseModel with _$ReservationItemOpenResponseModel {
  factory ReservationItemOpenResponseModel({
    int? code,
    String? message,
    List<Datum>? data,
  }) = _ReservationItemOpenResponseModel;

  factory ReservationItemOpenResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ReservationItemOpenResponseModelFromJson(json);
}
