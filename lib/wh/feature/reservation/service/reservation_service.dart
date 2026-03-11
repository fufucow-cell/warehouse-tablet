import 'package:dio/dio.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/model/reservation_item_model.dart';
import 'package:engo_terminal_app3/wh/parent/service/environment_service/environment_service.dart';

class ReservationService {
  ReservationService._internal();

  static final ReservationService instance = ReservationService._internal();

  static const String _reservationPath = '/api/v1/reservation';
  static const String _fallbackBaseUrl = 'http://127.0.0.1:8001';

  Future<List<ReservationItemModel>> fetchOpenItems() async {
    final Dio dio = _newDio();

    final Response<dynamic> response = await dio.get<dynamic>('/items');
    final dynamic data = response.data;

    if (data is! Map<String, dynamic>) {
      return <ReservationItemModel>[];
    }

    final dynamic itemsRaw = data['items'];
    if (itemsRaw is! List) {
      return <ReservationItemModel>[];
    }

    final List<ReservationItemModel> items = <ReservationItemModel>[];
    for (final dynamic row in itemsRaw) {
      if (row is Map<String, dynamic>) {
        final ReservationItemModel item = ReservationItemModel.fromJson(row);
        if (item.isPublished) {
          items.add(item);
        }
      }
    }
    return items;
  }

  Future<String> createBookingOrder({
    required String itemId,
    required int bookingStartAt,
    required int bookingEndAt,
    required int peopleCount,
    required String userName,
    required String userPhone,
    String note = '',
  }) async {
    final Dio dio = _newDio();
    final Response<dynamic> response = await dio.post<dynamic>(
      '/user-booking-orders',
      data: <String, dynamic>{
        'item_id': itemId,
        'booking_start_at': bookingStartAt,
        'booking_end_at': bookingEndAt,
        'people_count': peopleCount,
        'user_id': 'app_user_demo',
        'user_name': userName,
        'user_phone': userPhone,
        'note': note,
      },
    );

    final dynamic body = response.data;
    if (body is Map<String, dynamic>) {
      final String orderNo = (body['order_no'] ?? '').toString();
      if (orderNo.isNotEmpty) {
        return orderNo;
      }
      final String orderId = (body['id'] ?? '').toString();
      if (orderId.isNotEmpty) {
        return orderId;
      }
    }
    return 'created';
  }

  Dio _newDio() {
    final String baseUrl = _buildBaseUrl();
    return Dio(
      BaseOptions(
        baseUrl: '$baseUrl$_reservationPath',
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  String _buildBaseUrl() {
    final String envBaseUrl = EnvironmentService.instance.getBaseUrl.trim();
    if (envBaseUrl.isNotEmpty) {
      return _trimTrailingSlash(envBaseUrl);
    }
    return _fallbackBaseUrl;
  }

  String _trimTrailingSlash(String value) {
    if (value.endsWith('/')) {
      return value.substring(0, value.length - 1);
    }
    return value;
  }
}
