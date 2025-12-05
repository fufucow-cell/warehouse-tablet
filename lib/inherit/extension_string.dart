/// String 擴充方法
extension StringExtension on String {
  /// 轉換為 snake_case
  ///
  /// 將 camelCase 或 PascalCase 轉換為 snake_case
  /// 例如：'helloWorld' -> 'hello_world'
  ///      'HelloWorld' -> 'hello_world'
  String toSnakeCase() {
    if (isEmpty) {
      return this;
    }

    final buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      final char = this[i];
      if (char == char.toUpperCase() && i > 0) {
        buffer.write('_');
      }
      buffer.write(char.toLowerCase());
    }

    return buffer.toString();
  }

  /// 轉換為 camelCase
  ///
  /// 將 snake_case 轉換為 camelCase
  /// 例如：'hello_world' -> 'helloWorld'
  String toCamelCase() {
    if (isEmpty) {
      return this;
    }

    final parts = split('_');

    if (parts.length == 1) {
      return parts[0];
    }

    final buffer = StringBuffer(parts[0]);

    for (int i = 1; i < parts.length; i++) {
      final part = parts[i];
      if (part.isNotEmpty) {
        buffer.write(part[0].toUpperCase());
        if (part.length > 1) {
          buffer.write(part.substring(1));
        }
      }
    }

    return buffer.toString();
  }
}
