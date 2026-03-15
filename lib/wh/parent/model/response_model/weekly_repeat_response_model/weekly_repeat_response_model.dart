import 'package:engo_terminal_app3/wh/parent/model/response_model/weekly_repeat_response_model/period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_repeat_response_model.freezed.dart';
part 'weekly_repeat_response_model.g.dart';

@freezed
class WeeklyRepeatResponseModel with _$WeeklyRepeatResponseModel {
  factory WeeklyRepeatResponseModel({
    int? day,
    @JsonKey(name: 'is_enable') bool? isEnable,
    @JsonKey(name: 'is_all_day') bool? isAllDay,
    List<Period>? period,
  }) = _WeeklyRepeatResponseModel;

  factory WeeklyRepeatResponseModel.fromJson(Map<String, dynamic> json) => _$WeeklyRepeatResponseModelFromJson(json);
}
