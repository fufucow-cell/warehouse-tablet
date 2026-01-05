import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_category.freezed.dart';
part 'item_category.g.dart';

@freezed
class ItemCategory with _$ItemCategory {
  factory ItemCategory({
    String? id,
    String? name,
    @JsonKey(name: 'parent_id') String? parentId,
    ItemCategory? children,
  }) = _ItemCategory;

  factory ItemCategory.fromJson(Map<String, dynamic> json) => _$ItemCategoryFromJson(json);
}
