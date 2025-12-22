import 'package:freezed_annotation/freezed_annotation.dart';

part 'cabinet.freezed.dart';
part 'cabinet.g.dart';

@freezed
class Cabinet with _$Cabinet {
  factory Cabinet({
    @JsonKey(name: 'cabinet_name') String? cabinetName,
    List<int>? count,
  }) = _Cabinet;

  factory Cabinet.fromJson(Map<String, dynamic> json) => _$CabinetFromJson(json);
}
