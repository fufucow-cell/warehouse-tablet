import 'dart:io';

/// 生成 image_map.dart 的脚本
/// 从 warehouse/parent/assets/images/ 目录中提取所有图片，生成 EnumImage enum
/// 命名规则：
/// - common/ 目录下的文件：c + 文件名（PascalCase），例如 cCow, cHouse
/// - light/ 或 dark/ 目录下的文件：t + 文件名（PascalCase），例如 tCow
void main() {
  final imagesDir = Directory('lib/wh/feature/warehouse/parent/assets/images');
  final outputFile = File('lib/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart');

  if (!imagesDir.existsSync()) {
    print('Error: images directory not found');
    exit(1);
  }

  // 扫描图片文件
  final imageFiles = _scanImageFiles(imagesDir);

  if (imageFiles.isEmpty) {
    print('Error: No image files found in images directory');
    exit(1);
  }

  // 处理图片：按目录分类
  final imageMap = _processImages(imageFiles, imagesDir);

  // 生成 enum
  final generatedContent = _generateImageMap(imageMap);

  // 写入文件
  outputFile.writeAsStringSync(generatedContent);
  print('✅ Generated: ${outputFile.path}');
  print('📊 Total enum values: ${imageMap.length}');
}

/// 扫描图片文件
List<File> _scanImageFiles(Directory dir) {
  final files = <File>[];
  final imageExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.webp', '.svg'];

  void scan(Directory directory) {
    for (final entity in directory.listSync()) {
      if (entity is File) {
        final ext = entity.path.toLowerCase();
        if (imageExtensions.any((e) => ext.endsWith(e))) {
          files.add(entity);
        }
      } else if (entity is Directory) {
        scan(entity);
      }
    }
  }

  scan(dir);
  return files;
}

/// 处理图片文件，按目录分类
/// 返回 Map<enum名称, 文件信息>
Map<String, _ImageInfo> _processImages(
  List<File> files,
  Directory baseDir,
) {
  final basePath = baseDir.path;
  // 先按文件名分组，记录每个文件在哪些目录中存在
  final fileGroups = <String, Set<String>>{};

  for (final file in files) {
    final relativePath = file.path.replaceFirst('$basePath/', '');
    final segments = relativePath.split('/');

    if (segments.length < 2) {
      continue; // 跳过根目录下的文件
    }

    final folderName = segments[0]; // common, light, 或 dark
    final fileName = segments.last;
    final fileNameWithoutExt = fileName.split('.').first;

    // 只处理 common, light, dark 目录
    if (folderName != 'common' && folderName != 'light' && folderName != 'dark') {
      continue;
    }

    // 记录文件所在的目录
    if (!fileGroups.containsKey(fileNameWithoutExt)) {
      fileGroups[fileNameWithoutExt] = <String>{};
    }
    fileGroups[fileNameWithoutExt]!.add(folderName);
  }

  // 根据文件分组生成 enum
  final imageMap = <String, _ImageInfo>{};

  for (final entry in fileGroups.entries) {
    final fileName = entry.key;
    final folders = entry.value;

    final hasCommon = folders.contains('common');
    final hasTheme = folders.contains('light') || folders.contains('dark');

    // 如果文件在 common 目录中，生成 c 前缀的 enum
    if (hasCommon) {
      final enumName = 'c${_toPascalCase(fileName)}';
      imageMap[enumName] = _ImageInfo(
        fileName: fileName,
        folder: 'common',
      );
    }

    // 如果文件在 light 或 dark 目录中，生成 t 前缀的 enum
    if (hasTheme) {
      final enumName = 't${_toPascalCase(fileName)}';
      imageMap[enumName] = _ImageInfo(
        fileName: fileName,
        folder: 'light', // 使用 light 作为代表，实际路径由 ThemeUtil 根据主题决定
      );
    }
  }

  return imageMap;
}

/// 图片信息类
class _ImageInfo {
  final String fileName;
  final String folder; // common, light, 或 dark

  _ImageInfo({
    required this.fileName,
    required this.folder,
  });
}

/// 生成 image_map.dart 内容
String _generateImageMap(Map<String, _ImageInfo> imageMap) {
  final buffer = StringBuffer();

  // 文件头部
  buffer.writeln('/// 图片 Key 枚举');
  buffer.writeln('/// 自动生成，请勿手动修改');
  buffer.writeln('/// 生成时间: ${DateTime.now().toIso8601String()}');
  buffer.writeln('library;');
  buffer.writeln('');
  buffer.writeln("import 'package:flutter/material.dart';");
  buffer.writeln("import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme_service.dart';");
  buffer.writeln('');

  // 收集所有 enum 名称并排序
  final sortedEnumNames = imageMap.keys.toList()..sort();

  // Enum 定义
  buffer.writeln('enum EnumImage {');
  for (var i = 0; i < sortedEnumNames.length; i++) {
    final enumName = sortedEnumNames[i];
    final isLast = i == sortedEnumNames.length - 1;
    // 最后一个使用分号，其他使用逗号
    buffer.writeln('  $enumName${isLast ? ';' : ','}');
  }
  buffer.writeln('');
  buffer.writeln('  ThemeService get _themeService => ThemeService.instance;');
  buffer.writeln('');
  buffer.writeln('  /// 取得圖片路徑');
  buffer.writeln('  String get path => _themeService.getImagePath(this);');
  buffer.writeln('');
  buffer.writeln('  /// 取得圖片 Widget');
  buffer.writeln('  Widget image({Size? size, Color? color}) =>');
  buffer.writeln('      _themeService.getImageWidget(this, size: size, color: color);');
  buffer.writeln('');
  buffer.writeln('  /// 取得裝飾圖片');
  buffer.writeln('  DecorationImage get decorationImage => DecorationImage(');
  buffer.writeln('        image: AssetImage(path),');
  buffer.writeln('        fit: BoxFit.cover,');
  buffer.writeln('      );');
  buffer.writeln('}');

  return buffer.toString();
}

/// 将文件名转换为 PascalCase
/// 例如: 'cow' -> 'Cow', 'house_image' -> 'HouseImage'
String _toPascalCase(String input) {
  if (input.isEmpty) return input;

  // 如果包含下划线，按 snake_case 处理
  if (input.contains('_')) {
    final parts = input.split('_');
    return parts.map((part) {
      if (part.isEmpty) return '';
      return part[0].toUpperCase() + part.substring(1).toLowerCase();
    }).join('');
  }

  // 否则首字母大写，其余保持原样
  return input[0].toUpperCase() + input.substring(1);
}
