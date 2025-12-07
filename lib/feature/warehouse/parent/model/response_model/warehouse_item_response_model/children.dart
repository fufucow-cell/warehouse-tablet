import 'package:freezed_annotation/freezed_annotation.dart';

part 'children.freezed.dart';
part 'children.g.dart';

@freezed
class Children with _$Children {
  factory Children({
    @JsonKey(name: 'category_id') String? categoryId,
    String? name,
    int? level,
    dynamic children,
  }) = _Children;

  factory Children.fromJson(Map<String, dynamic> json) =>
      _$ChildrenFromJson(json);
}
