import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_record.freezed.dart';
part 'item_record.g.dart';

List<String>? _stringListFromJson(dynamic json) {
  if (json == null) return null;
  if (json is! List) return null;
  return json
      .map((e) => e == null ? null : e as String?)
      .whereType<String>()
      .toList();
}

List<String>? _categoryNameListFromJson(dynamic json) {
  if (json == null) return null;
  if (json is! List) return null;

  final List<String> result = [];
  for (final e in json) {
    if (e == null) continue;
    final str = e as String?;
    if (str == null || str.isEmpty) continue;

    // 如果字符串包含分号，则用箭头连接
    if (str.contains(';')) {
      final parts = str.split(';');
      final trimmedParts = parts
          .map((part) => part.trim())
          .where((part) => part.isNotEmpty)
          .toList();
      if (trimmedParts.isNotEmpty) {
        result.add(trimmedParts.join(' -> '));
      }
    } else {
      result.add(str);
    }
  }

  return result.isEmpty ? null : result;
}

@freezed
class ItemRecord with _$ItemRecord {
  factory ItemRecord({
    String? id,
    @JsonKey(name: 'household_id') String? householdId,
    @JsonKey(name: 'item_id') String? itemId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'operate_type') int? operateType,
    @JsonKey(name: 'entity_type') int? entityType,
    @JsonKey(name: 'item_name', fromJson: _stringListFromJson)
    List<String>? itemName,
    @JsonKey(name: 'item_description', fromJson: _stringListFromJson)
    List<String>? itemDescription,
    @JsonKey(name: 'item_photo', fromJson: _stringListFromJson)
    List<String>? itemPhoto,
    @JsonKey(name: 'item_min_stock_count') List<int>? itemMinStockCount,
    @JsonKey(name: 'category_name', fromJson: _categoryNameListFromJson)
    List<String>? categoryName,
    @JsonKey(name: 'cabinet_name', fromJson: _stringListFromJson)
    List<String>? cabinetName,
    @JsonKey(name: 'cabinet_room_name', fromJson: _stringListFromJson)
    List<String>? cabinetRoomName,
    @JsonKey(name: 'quantity_count') List<int>? quantityCount,
  }) = _ItemRecord;

  factory ItemRecord.fromJson(Map<String, dynamic> json) =>
      _$ItemRecordFromJson(json);
}
