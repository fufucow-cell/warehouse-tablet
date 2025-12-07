// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChildrenImpl _$$ChildrenImplFromJson(Map<String, dynamic> json) =>
    _$ChildrenImpl(
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      level: (json['level'] as num?)?.toInt(),
      children: json['children'],
    );

Map<String, dynamic> _$$ChildrenImplToJson(_$ChildrenImpl instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'name': instance.name,
      'level': instance.level,
      'children': instance.children,
    };
