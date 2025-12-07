import 'package:freezed_annotation/freezed_annotation.dart';

part 'cabinet.freezed.dart';
part 'cabinet.g.dart';

@freezed
class Cabinet with _$Cabinet {
  factory Cabinet({
    @JsonKey(name: 'cabinet_id') String? cabinetId,
    String? name,
    int? quantity,
  }) = _Cabinet;

  factory Cabinet.fromJson(Map<String, dynamic> json) =>
      _$CabinetFromJson(json);
}
