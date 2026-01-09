// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item_smart_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WarehouseItemSmartResponseModelImpl
    _$$WarehouseItemSmartResponseModelImplFromJson(Map<String, dynamic> json) =>
        _$WarehouseItemSmartResponseModelImpl(
          name: json['name'] as String?,
          description: json['description'] as String?,
          categoryId: json['category_id'] as String?,
          category: json['category'] as String?,
          isNewCategory: json['is_new_category'] as bool?,
          confidence: (json['confidence'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$WarehouseItemSmartResponseModelImplToJson(
        _$WarehouseItemSmartResponseModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category_id': instance.categoryId,
      'category': instance.category,
      'is_new_category': instance.isNewCategory,
      'confidence': instance.confidence,
    };
