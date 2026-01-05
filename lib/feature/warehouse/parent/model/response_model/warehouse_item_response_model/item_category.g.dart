// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemCategoryImpl _$$ItemCategoryImplFromJson(Map<String, dynamic> json) =>
    _$ItemCategoryImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      parentId: json['parent_id'] as String?,
      children: json['children'] == null
          ? null
          : ItemCategory.fromJson(json['children'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ItemCategoryImplToJson(_$ItemCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent_id': instance.parentId,
      'children': instance.children?.toJson(),
    };
