import 'package:collection/collection.dart';

enum EnumErrorMap {
  code200(200, 'Success'),
  code201(201, 'Unknown local error'),
  code202(202, 'Response format error'),
  code203(203, 'Response parser error'),
  code204(204, 'Token expired'),
  code205(205, 'Token invalid'),
  code100(100, 'Dio: Connection timeout'),
  code101(101, 'Dio: Send timeout'),
  code102(102, 'Dio: Receive timeout'),
  code103(103, 'Dio: Connection error'),
  code104(104, 'Dio: Bad certificate'),
  code105(105, 'Dio: Bad response'),
  code106(106, 'Dio: Cancel'),
  code107(107, 'Dio: Connection error'),
  code108(108, 'Dio: Unknown error'),
  code400(400, 'Bad request'),
  code401(401, 'Unauthorized'),
  code403(403, 'Forbidden'),
  code404(404, 'Not found'),
  code405(405, 'Method not allowed'),
  code408(408, 'Request timeout'),
  code409(409, 'Conflict'),
  code413(413, 'Payload too large'),
  code414(414, 'URI too long'),
  code415(415, 'Unsupported media type'),
  code422(422, 'Unprocessable entity'),
  code429(429, 'Too many requests'),
  code500(500, 'Internal server error'),
  code501(501, 'Not implemented'),
  code502(502, 'Bad gateway'),
  code503(503, 'Service unavailable'),
  code504(504, 'Gateway timeout');

  const EnumErrorMap(this.code, this.message);
  final int code;
  final String message;

  /// 根據錯誤代碼獲取錯誤消息
  static String getMessageByCode(int code) {
    return EnumErrorMap.values
            .firstWhereOrNull(
              (e) => e.code == code,
            )
            ?.message ??
        EnumErrorMap.code201.message;
  }
}
