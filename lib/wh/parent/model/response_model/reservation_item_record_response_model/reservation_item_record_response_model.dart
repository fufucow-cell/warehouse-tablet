import 'package:engo_terminal_app3/wh/parent/model/response_model/reservation_item_record_response_model/datum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_item_record_response_model.freezed.dart';
part 'reservation_item_record_response_model.g.dart';

@freezed
class ReservationItemRecordResponseModel
    with _$ReservationItemRecordResponseModel {
  factory ReservationItemRecordResponseModel({
    int? code,
    String? message,
    List<Datum>? data,
  }) = _ReservationItemRecordResponseModel;

  factory ReservationItemRecordResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ReservationItemRecordResponseModelFromJson(json);
}
