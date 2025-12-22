import 'dart:io';

// Simple logger replacement
class _Logger {
  void i(String message) => print('[INFO] $message');
  void e(String message) => print('[ERROR] $message');
  void d(String message) => print('[DEBUG] $message');
}

final logger = _Logger();

final _assetsThemePath = 'assets/theme';
final _assetsL10nPath = 'assets/l10n';
final _outputFilePath = 'lib/ui/theme/media.dart';

void main() {
  final mediaPaths = getAllMediaPaths;
  final usedNames = <String>{};
  final fileNameToParent = <String, String>{};

  final iconList = <Map<String, String>>[];

  for (var path in mediaPaths) {
    final result = pathToName(path, usedNames, fileNameToParent);
    if (result == null) {
      continue; // 跳過已重複的
    }
    final name = result['name'] as String;
    final newPath = result['path']!;
    iconList.add({'name': name, 'path': newPath});
  }

  // 如果路徑有 guide/$_languageName，就改成 guide/$_languageZhEn
  for (var item in iconList) {
    item['path'] = item['path']!.replaceAll('guide/\$_languageName', 'guide/\$_languageZhEn');
  }

  generateIconAndPathClasses(iconList, _outputFilePath);
  logger.i('完成產出：$_outputFilePath');
}

/// 支援的多媒體副檔名
const mediaExtensions = [
  '.png',
  '.jpg',
  '.jpeg',
  '.gif',
  '.bmp',
  '.webp',
  '.mp4',
  '.mov',
  '.avi',
  '.mkv',
  '.webm',
  '.flv',
];

List<String> getSubFolders(String parentPath) {
  final dir = Directory(parentPath);

  if (!dir.existsSync()) {
    return [];
  }

  final List<String> folders = [];

  for (var entity in dir.listSync(followLinks: false)) {
    if (entity is Directory) {
      folders.add(entity.path.split('/').last);
    }
  }
  return folders;
}

String toSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'[A-Z]'), (m) => '_${m.group(0)!.toLowerCase()}').replaceAll(RegExp(r'^_'), '');
}

List<String> get getAllMediaPaths {
  final result = <String>[];
  final dir = Directory('assets');

  if (!dir.existsSync()) {
    return result;
  }

  for (var entity in dir.listSync(recursive: true, followLinks: false)) {
    if (entity is File) {
      final ext = entity.path.toLowerCase();
      if (mediaExtensions.any((e) => ext.endsWith(e))) {
        result.add(entity.path);
      }
    }
  }
  return result;
}

// 將路徑轉成名稱，用於建 enumName，並處理 theme/l10n/iname
Map<String, String>? pathToName(
  String path,
  Set<String> usedNames,
  Map<String, String> fileNameToParent,
) {
  final themeNameList = getSubFolders(_assetsThemePath);
  final l10nNameList = getSubFolders(_assetsL10nPath);

  final segments = path.split('/');
  final fileName = segments.last.split('.').first;
  String parent = segments.length > 1 ? segments[segments.length - 2] : '';

  // 換 theme 夾成 $_themeName
  for (int i = 0; i < segments.length; i++) {
    if (themeNameList.contains(segments[i])) {
      segments[i] = r'$_themeName';

      if (i == segments.length - 2) {
        parent = r'$_themeName';
      }
    }
  }
  // 換 l10n 夾成 $_languageName
  for (int i = 0; i < segments.length; i++) {
    if (l10nNameList.contains(segments[i])) {
      segments[i] = r'$_languageName';

      if (i == segments.length - 2) {
        parent = r'$_languageName';
      }
    }
  }

  final parts = fileName.split('_');
  String baseKey = parts.first.toLowerCase() + parts.skip(1).map((e) => e.isNotEmpty ? e[0].toUpperCase() + e.substring(1) : '').join();

  bool isTheme = segments.contains('theme');
  bool isL10n = segments.contains('l10n');
  bool isImages = segments.contains('images');

  String name = baseKey;

  if (fileNameToParent.containsKey(baseKey)) {
    final prevParent = fileNameToParent[baseKey];
    if (isTheme && prevParent != 'theme') {
      name = 'theme${baseKey[0].toUpperCase()}${baseKey.substring(1)}';
    } else if (!isTheme && prevParent == 'theme') {
      // 保持
    } else if (isL10n && prevParent != 'l10n') {
      name = 'l10n${baseKey[0].toUpperCase()}${baseKey.substring(1)}';
    } else if (!isL10n && prevParent == 'l10n') {
      // 保持
    } else if (prevParent == (isTheme ? 'theme' : (isL10n ? 'l10n' : (isImages ? 'images' : parent)))) {
      return null;
    } else {
      final parentParts = parent.split('_');
      final parentCamel =
          parentParts.first.toLowerCase() + parentParts.skip(1).map((e) => e.isNotEmpty ? e[0].toUpperCase() + e.substring(1) : '').join();
      name = parentCamel + baseKey[0].toUpperCase() + baseKey.substring(1);
    }
  }

  if (usedNames.contains(name)) {
    return null;
  }

  usedNames.add(name);
  fileNameToParent[baseKey] = isTheme ? 'theme' : (isL10n ? 'l10n' : (isImages ? 'images' : parent));

  return {
    'name': name,
    'path': segments.join('/'),
  };
}

// 產生兩個 class 合併成一個
void generateIconAndPathClasses(List<Map<String, String>> iconList, String outputPath) {
  final buffer = StringBuffer();

  buffer.writeln('// 本檔案由 script 自動產生，請勿手動修改。');
  buffer.writeln('// ignore_for_file: constant_identifier_names, non_constant_identifier_names');
  buffer.writeln("part of 'resource.dart';\n");
  // 產生 AppIcon2 (static widgets)
  buffer.writeln('class AppIcon2 {');
  for (var entry in iconList) {
    final name = entry['name']!;
    final path = entry['path']!;
    buffer.writeln('  static Widget $name({Color? color, Size? size, double? length}) => Image.asset(');
    buffer.writeln("        '$path',");
    buffer.writeln('        color: color,');
    buffer.writeln('        width: size?.width ?? length,');
    buffer.writeln('        height: size?.height ?? length,');
    buffer.writeln('      );');
  }
  buffer.writeln('}\n');

  // 產生 AppImageName2 (字串路徑)
  buffer.writeln('class AppImageName2 {');
  for (var entry in iconList) {
    final name = entry['name']!;
    final path = entry['path']!;
    buffer.writeln('  static String get $name => \'$path\';');
  }
  buffer.writeln('}');

  // 寫入檔案
  File(outputPath).writeAsStringSync(buffer.toString());
}
