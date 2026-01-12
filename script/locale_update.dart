import 'dart:io';

/// 生成 locale_map.dart 的脚本
/// 从多语系文件中提取所有 key，生成 EnumLocale enum 和 tr 方法
void main() {
  final localesDir = Directory('lib/feature/warehouse/parent/service/locale_service/locale');
  final outputFile = File('lib/feature/warehouse/parent/service/locale_service/locale/locale_map.dart');

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
  final regex = RegExp(r"'([a-z][a-zA-Z0-9]*)':\s*'[^']*'", multiLine: true);

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
  buffer.writeln('/// 生成时间: ${DateTime.now().toIso8601String()}');
  buffer.writeln('library;');
  buffer.writeln('');
  buffer.writeln("import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale_service_model.dart';");
  buffer.writeln("import 'package:get/get.dart';");
  buffer.writeln('');

  // Enum 定义（使用增强 enum，getter 直接写在 enum 内部）
  buffer.writeln('enum EnumLocale {');
  for (var i = 0; i < keys.length; i++) {
    final key = keys[i];
    final isLast = i == keys.length - 1;
    // 最后一个使用分号，其他使用逗号
    buffer.writeln('  $key${isLast ? ';' : ','}');
  }
  buffer.writeln('');
  buffer.writeln('  String get key => name;');
  buffer.writeln('  ');
  buffer.writeln('  // Get 版本');
  buffer.writeln('  // String get tr => key.tr;');
  buffer.writeln('  // String trArgs(List<String> params) {');
  buffer.writeln('  //   Map<String, String> namedParams = {};');
  buffer.writeln('  //   for (int i = 0; i < params.length; i++) {');
  buffer.writeln("  //     namedParams['para\${i + 1}'] = params[i];");
  buffer.writeln('  //   }');
  buffer.writeln('  //   return key.trParams(namedParams);');
  buffer.writeln('  // }');
  buffer.writeln('');
  buffer.writeln('  // Module 版本');
  buffer.writeln('  static LocaleTranslation? _currentTranslation;');
  buffer.writeln('  ');
  buffer.writeln('  static void setCurrentTranslation(LocaleTranslation translation) => _currentTranslation = translation;');
  buffer.writeln('  ');
  buffer.writeln('  String get tr => _currentTranslation?.translationMap[key] ?? key;');
  buffer.writeln('  ');
  buffer.writeln('  String trArgs(List<String> params) {');
  buffer.writeln('    String strTr = _currentTranslation?.translationMap[key] ?? key;');
  buffer.writeln('    for (int i = 0; i < params.length; i++) {');
  buffer.writeln("      final keyPara = '@para\${i + 1}';");
  buffer.writeln('      strTr = strTr.replaceFirst(keyPara, params[i]);');
  buffer.writeln('    }');
  buffer.writeln('    return strTr;');
  buffer.writeln('  }');
  buffer.writeln('}');

  return buffer.toString();
}
