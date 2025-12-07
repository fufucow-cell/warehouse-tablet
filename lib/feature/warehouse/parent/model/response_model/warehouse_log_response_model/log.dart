import 'package:freezed_annotation/freezed_annotation.dart';

part 'log.freezed.dart';
part 'log.g.dart';

@freezed
class Log with _$Log {
  factory Log({
    @JsonKey(name: 'log_id') String? logId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'entity_type') int? entityType,
    @JsonKey(name: 'log_type') int? logType,
    @JsonKey(name: 'entity_name') List<String?>? entityName,
    @JsonKey(name: 'description_name')
    List<String?>? descriptionName,
    @JsonKey(name: 'category_name')
    List<String?>? categoryName,
    @JsonKey(name: 'quantity_count')
    List<int?>? quantityCount,
    @JsonKey(name: 'min_stock_count')
    List<int?>? minStockCount,
    @JsonKey(name: 'room_name') List<String?>? roomName,
    @JsonKey(name: 'photo_url') List<String?>? photoUrl,
  }) = _Log;

  factory Log.fromJson(Map<String, dynamic> json) =>
      _$LogFromJson(json);
}
