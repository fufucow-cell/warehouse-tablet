import 'package:dio/dio.dart';

/// Api Service Model
class ApiServiceModel {
  ApiServiceModel._();
  static final ApiServiceModel instance = ApiServiceModel._();

  /// Dio instance
  final Dio dio = Dio();
}
