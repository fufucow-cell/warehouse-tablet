// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      parentId: json['parent_id'],
      level: (json['level'] as num?)?.toInt(),
      children: json['children'] == null
          ? null
          : Children.fromJson(json['children'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'parent_id': instance.parentId,
      'level': instance.level,
      'children': instance.children?.toJson(),
    };
