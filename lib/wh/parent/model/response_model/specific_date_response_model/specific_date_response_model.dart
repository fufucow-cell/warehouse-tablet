import 'package:freezed_annotation/freezed_annotation.dart';

part 'specific_date_response_model.freezed.dart';
part 'specific_date_response_model.g.dart';

@freezed
class SpecificDateResponseModel with _$SpecificDateResponseModel {
  factory SpecificDateResponseModel({
    @JsonKey(name: 'booking_date') int? bookingDate,
    @JsonKey(name: 'is_all_day') bool? isAllDay,
    @JsonKey(name: 'start_time') String? startTime,
    @JsonKey(name: 'end_time') String? endTime,
  }) = _SpecificDateResponseModel;

  factory SpecificDateResponseModel.fromJson(Map<String, dynamic> json) => _$SpecificDateResponseModelFromJson(json);
}
