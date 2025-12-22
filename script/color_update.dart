import 'dart:io';

/// 生成 color_map.dart 的脚本
/// 从 color_data.dart 中提取所有 color key，生成 EnumColor enum
void main() {
  final colorDataFile = File('lib/feature/warehouse/parent/constant/theme/color_data.dart');
  final outputFile = File('lib/feature/warehouse/parent/constant/theme/color_map.dart');

  if (!colorDataFile.existsSync()) {
    print('Error: color_data.dart not found');
    exit(1);
  }

  final content = colorDataFile.readAsStringSync();
  final allKeys = _extractKeys(content);

  if (allKeys.isEmpty) {
    print('Error: No keys found in color_data.dart');
    exit(1);
  }

  // 分离 gradient 键和普通键
  final gradientKeys = <String, List<String>>{};
  final normalKeys = <String>[];

  for (final key in allKeys) {
    // 匹配 camelCase 格式的 gradient key，如 'backgroundItemGradient1', 'backgroundItemGradient2'
    final gradientMatch = RegExp(r'^(.+Gradient)(\d+)$').firstMatch(key);
    if (gradientMatch != null) {
      final baseName = gradientMatch.group(1)!;
      gradientKeys.putIfAbsent(baseName, () => []).add(key);
    } else {
      normalKeys.add(key);
    }
  }

  // 对每个 gradient 组的键进行排序
  for (final entry in gradientKeys.entries) {
    entry.value.sort((a, b) {
      final numA = int.tryParse(RegExp(r'Gradient(\d+)$').firstMatch(a)?.group(1) ?? '0') ?? 0;
      final numB = int.tryParse(RegExp(r'Gradient(\d+)$').firstMatch(b)?.group(1) ?? '0') ?? 0;
      return numA.compareTo(numB);
    });
  }

  // 生成 enum 和 getter 方法
  final generatedContent = _generateColorMap(normalKeys, gradientKeys);

  // 写入文件
  outputFile.writeAsStringSync(generatedContent);
  print('✅ Generated: ${outputFile.path}');
  print('📊 Total color keys: ${allKeys.length}');
  print('   - Normal keys: ${normalKeys.length}');
  print('   - Gradient groups: ${gradientKeys.length}');
}

/// 从文件内容中提取所有 color key
List<String> _extractKeys(String content) {
  final keys = <String>[];
  // 匹配 'keyName': ColorData(...) 格式，支持 colorDataMap 或 colors
  final regex = RegExp(r"Map<String, ColorData>\s+(?:colorDataMap|colors)\s*=\s*\{([^}]+)\}", multiLine: true);
  final mapMatch = regex.firstMatch(content);
  if (mapMatch != null) {
    final mapContent = mapMatch.group(1)!;
    final keyRegex = RegExp(r"'([a-z][a-zA-Z0-9]*)':\s*ColorData\s*\(", multiLine: true);
    for (final match in keyRegex.allMatches(mapContent)) {
      final key = match.group(1);
      if (key != null && !keys.contains(key)) {
        keys.add(key);
      }
    }
  } else {
    // 回退到旧的方式
    final keyRegex = RegExp(r"'([a-z][a-zA-Z0-9]*)':\s*ColorData\s*\(", multiLine: true);
    for (final match in keyRegex.allMatches(content)) {
      final key = match.group(1);
      if (key != null && !keys.contains(key)) {
        keys.add(key);
      }
    }
  }

  // 排序以便更好的可读性
  keys.sort();
  return keys;
}

/// 生成 color_map.dart 内容
String _generateColorMap(
  List<String> normalKeys,
  Map<String, List<String>> gradientKeys,
) {
  final buffer = StringBuffer();

  // 文件头部
  buffer.writeln('/// 颜色 Key 枚举');
  buffer.writeln('/// 自动生成，请勿手动修改');
  buffer.writeln('/// 生成时间: ${DateTime.now().toIso8601String()}');
  buffer.writeln('library;');
  buffer.writeln('');
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln("import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_data.dart';");
  buffer.writeln("import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/theme_constant.dart';");
  buffer.writeln("import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/theme_util.dart';");
  buffer.writeln('');

  // 收集所有枚举值
  final enumEntries = <String, bool>{}; // key: enumName, value: isGradient

  // 添加普通键
  for (final key in normalKeys) {
    // key 已经是 camelCase 格式，直接使用
    enumEntries[key] = false;
  }

  // 添加 gradient 键
  for (final baseName in gradientKeys.keys) {
    // baseName 已经是 camelCase 格式（如 'backgroundItemGradient'），直接使用作为 enumName
    enumEntries[baseName] = true;
  }

  // 排序枚举值
  final sortedEnumNames = enumEntries.keys.toList()..sort();

  // Enum 定义
  buffer.writeln('enum EnumColor {');
  for (var i = 0; i < sortedEnumNames.length; i++) {
    final enumName = sortedEnumNames[i];
    final isLast = i == sortedEnumNames.length - 1;
    // 最后一个使用分号，其他使用逗号
    buffer.writeln('  $enumName${isLast ? ';' : ','}');
  }
  buffer.writeln('');
  buffer.writeln('  String get key => name;');
  buffer.writeln('');
  buffer.writeln('  Color get color => _getColor(colorDataMap[key]);');
  buffer.writeln('');
  buffer.writeln('  List<Color> get colors {');
  buffer.writeln('    final result = <Color>[];');
  buffer.writeln('');
  buffer.writeln('    for (var num = 1; num <= 100; num++) {');
  buffer.writeln('      final colorData = colorDataMap[\'\${key}\$num\'];');
  buffer.writeln('');
  buffer.writeln('      if (colorData == null) {');
  buffer.writeln('        break;');
  buffer.writeln('      }');
  buffer.writeln('');
  buffer.writeln('      result.add(_getColor(colorData));');
  buffer.writeln('    }');
  buffer.writeln('');
  buffer.writeln('    return result;');
  buffer.writeln('  }');
  buffer.writeln('');
  buffer.writeln('  Color _getColor(ColorData? data) {');
  buffer.writeln('    if (data == null) {');
  buffer.writeln('      return Colors.transparent;');
  buffer.writeln('    }');
  buffer.writeln('');
  buffer.writeln('    final themeUtil = ThemeUtil.instance;');
  buffer.writeln('    return switch (themeUtil.currentTheme) {');
  buffer.writeln('      EnumThemeMode.light => data.light,');
  buffer.writeln('      EnumThemeMode.dark => data.dark,');
  buffer.writeln('      EnumThemeMode.system =>');
  buffer.writeln('        themeUtil.getThemeFromSystem == EnumThemeMode.light');
  buffer.writeln('            ? data.light');
  buffer.writeln('            : data.dark,');
  buffer.writeln('    };');
  buffer.writeln('  }');
  buffer.writeln('}');

  return buffer.toString();
}
