import 'dart:io';

/// 生成 locale_map.dart 的脚本
/// 从多语系文件中提取所有 key，生成 EnumLocale enum 和 tr 方法
void main() {
  final localesDir = Directory(
      'lib/feature/warehouse/parent/constant/locales');
  final outputFile = File(
      'lib/feature/warehouse/parent/constant/locales/locale_map.dart');

  // 读取 zh_tw.dart 作为基准，提取所有 key
  final zhTWFile = File('${localesDir.path}/zh_tw.dart');
  if (!zhTWFile.existsSync()) {
    print('Error: zh_tw.dart not found');
    exit(1);
  }

  final content = zhTWFile.readAsStringSync();
  final keys = _extractKeys(content);

  if (keys.isEmpty) {
    print('Error: No keys found in zh_tw.dart');
    exit(1);
  }

  // 生成 enum 和 tr 方法
  final generatedContent = _generateLocaleMap(keys);

  // 写入文件
  outputFile.writeAsStringSync(generatedContent);
  print('✅ Generated: ${outputFile.path}');
  print('📊 Total keys: ${keys.length}');
}

/// 从文件内容中提取所有 key
List<String> _extractKeys(String content) {
  final keys = <String>[];
  final regex =
      RegExp(r"'([a-z0-9_]+)':\s*'[^']*'", multiLine: true);

  for (final match in regex.allMatches(content)) {
    final key = match.group(1);
    if (key != null && !keys.contains(key)) {
      keys.add(key);
    }
  }

  // 排序以便更好的可读性
  keys.sort();
  return keys;
}

/// 生成 locale_map.dart 内容
String _generateLocaleMap(List<String> keys) {
  final buffer = StringBuffer();

  // 文件头部
  buffer.writeln('/// 多语系 Key 枚举');
  buffer.writeln('/// 自动生成，请勿手动修改');
  buffer.writeln(
      '/// 生成时间: ${DateTime.now().toIso8601String()}');
  buffer.writeln('library;');
  buffer.writeln('');
  buffer.writeln(
      "import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_string.dart';");
  buffer.writeln("import 'package:get/get.dart';");
  buffer.writeln('');

  // Enum 定义（使用增强 enum，getter 直接写在 enum 内部）
  buffer.writeln('enum EnumLocale {');
  for (var i = 0; i < keys.length; i++) {
    final key = keys[i];
    final enumName = _keyToEnumName(key);
    final isLast = i == keys.length - 1;
    // 最后一个使用分号，其他使用逗号
    buffer.writeln('  $enumName${isLast ? ';' : ','}');
  }
  buffer.writeln('');
  buffer.writeln('  String get key => name.toSnakeCase();');
  buffer.writeln('  String get tr => key.tr;');
  buffer.writeln('}');

  return buffer.toString();
}

/// 将 key 转换为 enum 名称
/// 例如: 'app_title' -> 'appTitle', 'search_name_hint_item' -> 'searchNameHintItem'
String _keyToEnumName(String key) {
  final parts = key.split('_');
  if (parts.isEmpty) return key;

  final camelCase = parts.first +
      parts.skip(1).map((part) {
        if (part.isEmpty) return '';
        return part[0].toUpperCase() + part.substring(1);
      }).join('');

  // 确保首字母小写
  return camelCase;
}
