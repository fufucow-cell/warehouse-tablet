// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_item_smart_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseItemSmartResponseModel _$WarehouseItemSmartResponseModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseItemSmartResponseModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseItemSmartResponseModel {
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  String? get categoryId => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_new_category')
  bool? get isNewCategory => throw _privateConstructorUsedError;
  int? get confidence => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseItemSmartResponseModelCopyWith<WarehouseItemSmartResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseItemSmartResponseModelCopyWith<$Res> {
  factory $WarehouseItemSmartResponseModelCopyWith(
          WarehouseItemSmartResponseModel value,
          $Res Function(WarehouseItemSmartResponseModel) then) =
      _$WarehouseItemSmartResponseModelCopyWithImpl<$Res,
          WarehouseItemSmartResponseModel>;
  @useResult
  $Res call(
      {String? name,
      String? description,
      @JsonKey(name: 'category_id') String? categoryId,
      String? category,
      @JsonKey(name: 'is_new_category') bool? isNewCategory,
      int? confidence});
}

/// @nodoc
class _$WarehouseItemSmartResponseModelCopyWithImpl<$Res,
        $Val extends WarehouseItemSmartResponseModel>
    implements $WarehouseItemSmartResponseModelCopyWith<$Res> {
  _$WarehouseItemSmartResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? category = freezed,
    Object? isNewCategory = freezed,
    Object? confidence = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isNewCategory: freezed == isNewCategory
          ? _value.isNewCategory
          : isNewCategory // ignore: cast_nullable_to_non_nullable
              as bool?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseItemSmartResponseModelImplCopyWith<$Res>
    implements $WarehouseItemSmartResponseModelCopyWith<$Res> {
  factory _$$WarehouseItemSmartResponseModelImplCopyWith(
          _$WarehouseItemSmartResponseModelImpl value,
          $Res Function(_$WarehouseItemSmartResponseModelImpl) then) =
      __$$WarehouseItemSmartResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? description,
      @JsonKey(name: 'category_id') String? categoryId,
      String? category,
      @JsonKey(name: 'is_new_category') bool? isNewCategory,
      int? confidence});
}

/// @nodoc
class __$$WarehouseItemSmartResponseModelImplCopyWithImpl<$Res>
    extends _$WarehouseItemSmartResponseModelCopyWithImpl<$Res,
        _$WarehouseItemSmartResponseModelImpl>
    implements _$$WarehouseItemSmartResponseModelImplCopyWith<$Res> {
  __$$WarehouseItemSmartResponseModelImplCopyWithImpl(
      _$WarehouseItemSmartResponseModelImpl _value,
      $Res Function(_$WarehouseItemSmartResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? category = freezed,
    Object? isNewCategory = freezed,
    Object? confidence = freezed,
  }) {
    return _then(_$WarehouseItemSmartResponseModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isNewCategory: freezed == isNewCategory
          ? _value.isNewCategory
          : isNewCategory // ignore: cast_nullable_to_non_nullable
              as bool?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseItemSmartResponseModelImpl
    implements _WarehouseItemSmartResponseModel {
  _$WarehouseItemSmartResponseModelImpl(
      {this.name,
      this.description,
      @JsonKey(name: 'category_id') this.categoryId,
      this.category,
      @JsonKey(name: 'is_new_category') this.isNewCategory,
      this.confidence});

  factory _$WarehouseItemSmartResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseItemSmartResponseModelImplFromJson(json);

  @override
  final String? name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @override
  final String? category;
  @override
  @JsonKey(name: 'is_new_category')
  final bool? isNewCategory;
  @override
  final int? confidence;

  @override
  String toString() {
    return 'WarehouseItemSmartResponseModel(name: $name, description: $description, categoryId: $categoryId, category: $category, isNewCategory: $isNewCategory, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseItemSmartResponseModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isNewCategory, isNewCategory) ||
                other.isNewCategory == isNewCategory) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, categoryId,
      category, isNewCategory, confidence);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseItemSmartResponseModelImplCopyWith<
          _$WarehouseItemSmartResponseModelImpl>
      get copyWith => __$$WarehouseItemSmartResponseModelImplCopyWithImpl<
          _$WarehouseItemSmartResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseItemSmartResponseModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseItemSmartResponseModel
    implements WarehouseItemSmartResponseModel {
  factory _WarehouseItemSmartResponseModel(
      {final String? name,
      final String? description,
      @JsonKey(name: 'category_id') final String? categoryId,
      final String? category,
      @JsonKey(name: 'is_new_category') final bool? isNewCategory,
      final int? confidence}) = _$WarehouseItemSmartResponseModelImpl;

  factory _WarehouseItemSmartResponseModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseItemSmartResponseModelImpl.fromJson;

  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'category_id')
  String? get categoryId;
  @override
  String? get category;
  @override
  @JsonKey(name: 'is_new_category')
  bool? get isNewCategory;
  @override
  int? get confidence;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseItemSmartResponseModelImplCopyWith<
          _$WarehouseItemSmartResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
