// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'warehouse_log_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WarehouseRecordRequestModel _$WarehouseRecordRequestModelFromJson(
    Map<String, dynamic> json) {
  return _WarehouseRecordRequestModel.fromJson(json);
}

/// @nodoc
mixin _$WarehouseRecordRequestModel {
  @JsonKey(name: 'log_id')
  String? get logId => throw _privateConstructorUsedError;
  @JsonKey(name: 'household_id')
  String? get householdId => throw _privateConstructorUsedError;
  @JsonKey(name: 'after_time')
  int? get afterTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'operate_type')
  int? get operateType => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_type')
  int? get itemType => throw _privateConstructorUsedError;
  @JsonKey(name: 'log_type')
  int? get logType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WarehouseRecordRequestModelCopyWith<WarehouseRecordRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarehouseRecordRequestModelCopyWith<$Res> {
  factory $WarehouseRecordRequestModelCopyWith(
          WarehouseRecordRequestModel value,
          $Res Function(WarehouseRecordRequestModel) then) =
      _$WarehouseRecordRequestModelCopyWithImpl<$Res,
          WarehouseRecordRequestModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'log_id') String? logId,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'after_time') int? afterTime,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'item_type') int? itemType,
      @JsonKey(name: 'log_type') int? logType});
}

/// @nodoc
class _$WarehouseRecordRequestModelCopyWithImpl<$Res,
        $Val extends WarehouseRecordRequestModel>
    implements $WarehouseRecordRequestModelCopyWith<$Res> {
  _$WarehouseRecordRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = freezed,
    Object? householdId = freezed,
    Object? afterTime = freezed,
    Object? operateType = freezed,
    Object? itemType = freezed,
    Object? logType = freezed,
  }) {
    return _then(_value.copyWith(
      logId: freezed == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      afterTime: freezed == afterTime
          ? _value.afterTime
          : afterTime // ignore: cast_nullable_to_non_nullable
              as int?,
      operateType: freezed == operateType
          ? _value.operateType
          : operateType // ignore: cast_nullable_to_non_nullable
              as int?,
      itemType: freezed == itemType
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as int?,
      logType: freezed == logType
          ? _value.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WarehouseRecordRequestModelImplCopyWith<$Res>
    implements $WarehouseRecordRequestModelCopyWith<$Res> {
  factory _$$WarehouseRecordRequestModelImplCopyWith(
          _$WarehouseRecordRequestModelImpl value,
          $Res Function(_$WarehouseRecordRequestModelImpl) then) =
      __$$WarehouseRecordRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'log_id') String? logId,
      @JsonKey(name: 'household_id') String? householdId,
      @JsonKey(name: 'after_time') int? afterTime,
      @JsonKey(name: 'operate_type') int? operateType,
      @JsonKey(name: 'item_type') int? itemType,
      @JsonKey(name: 'log_type') int? logType});
}

/// @nodoc
class __$$WarehouseRecordRequestModelImplCopyWithImpl<$Res>
    extends _$WarehouseRecordRequestModelCopyWithImpl<$Res,
        _$WarehouseRecordRequestModelImpl>
    implements _$$WarehouseRecordRequestModelImplCopyWith<$Res> {
  __$$WarehouseRecordRequestModelImplCopyWithImpl(
      _$WarehouseRecordRequestModelImpl _value,
      $Res Function(_$WarehouseRecordRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logId = freezed,
    Object? householdId = freezed,
    Object? afterTime = freezed,
    Object? operateType = freezed,
    Object? itemType = freezed,
    Object? logType = freezed,
  }) {
    return _then(_$WarehouseRecordRequestModelImpl(
      logId: freezed == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
              as String?,
      householdId: freezed == householdId
          ? _value.householdId
          : householdId // ignore: cast_nullable_to_non_nullable
              as String?,
      afterTime: freezed == afterTime
          ? _value.afterTime
          : afterTime // ignore: cast_nullable_to_non_nullable
              as int?,
      operateType: freezed == operateType
          ? _value.operateType
          : operateType // ignore: cast_nullable_to_non_nullable
              as int?,
      itemType: freezed == itemType
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as int?,
      logType: freezed == logType
          ? _value.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WarehouseRecordRequestModelImpl
    implements _WarehouseRecordRequestModel {
  _$WarehouseRecordRequestModelImpl(
      {@JsonKey(name: 'log_id') this.logId,
      @JsonKey(name: 'household_id') this.householdId,
      @JsonKey(name: 'after_time') this.afterTime,
      @JsonKey(name: 'operate_type') this.operateType,
      @JsonKey(name: 'item_type') this.itemType,
      @JsonKey(name: 'log_type') this.logType});

  factory _$WarehouseRecordRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WarehouseRecordRequestModelImplFromJson(json);

  @override
  @JsonKey(name: 'log_id')
  final String? logId;
  @override
  @JsonKey(name: 'household_id')
  final String? householdId;
  @override
  @JsonKey(name: 'after_time')
  final int? afterTime;
  @override
  @JsonKey(name: 'operate_type')
  final int? operateType;
  @override
  @JsonKey(name: 'item_type')
  final int? itemType;
  @override
  @JsonKey(name: 'log_type')
  final int? logType;

  @override
  String toString() {
    return 'WarehouseRecordRequestModel(logId: $logId, householdId: $householdId, afterTime: $afterTime, operateType: $operateType, itemType: $itemType, logType: $logType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WarehouseRecordRequestModelImpl &&
            (identical(other.logId, logId) || other.logId == logId) &&
            (identical(other.householdId, householdId) ||
                other.householdId == householdId) &&
            (identical(other.afterTime, afterTime) ||
                other.afterTime == afterTime) &&
            (identical(other.operateType, operateType) ||
                other.operateType == operateType) &&
            (identical(other.itemType, itemType) ||
                other.itemType == itemType) &&
            (identical(other.logType, logType) || other.logType == logType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, logId, householdId, afterTime,
      operateType, itemType, logType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WarehouseRecordRequestModelImplCopyWith<_$WarehouseRecordRequestModelImpl>
      get copyWith => __$$WarehouseRecordRequestModelImplCopyWithImpl<
          _$WarehouseRecordRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WarehouseRecordRequestModelImplToJson(
      this,
    );
  }
}

abstract class _WarehouseRecordRequestModel
    implements WarehouseRecordRequestModel {
  factory _WarehouseRecordRequestModel(
          {@JsonKey(name: 'log_id') final String? logId,
          @JsonKey(name: 'household_id') final String? householdId,
          @JsonKey(name: 'after_time') final int? afterTime,
          @JsonKey(name: 'operate_type') final int? operateType,
          @JsonKey(name: 'item_type') final int? itemType,
          @JsonKey(name: 'log_type') final int? logType}) =
      _$WarehouseRecordRequestModelImpl;

  factory _WarehouseRecordRequestModel.fromJson(Map<String, dynamic> json) =
      _$WarehouseRecordRequestModelImpl.fromJson;

  @override
  @JsonKey(name: 'log_id')
  String? get logId;
  @override
  @JsonKey(name: 'household_id')
  String? get householdId;
  @override
  @JsonKey(name: 'after_time')
  int? get afterTime;
  @override
  @JsonKey(name: 'operate_type')
  int? get operateType;
  @override
  @JsonKey(name: 'item_type')
  int? get itemType;
  @override
  @JsonKey(name: 'log_type')
  int? get logType;
  @override
  @JsonKey(ignore: true)
  _$$WarehouseRecordRequestModelImplCopyWith<_$WarehouseRecordRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
