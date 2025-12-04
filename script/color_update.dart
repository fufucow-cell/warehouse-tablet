import 'dart:io';

import 'package:flutter_ars_bank/utils/logger.dart';
// import 'package:path/path.dart' as path;

final _colorFilePath = 'lib/ui/theme/color.dart';

void main() {
  convertColors();
}

Future<void> _convertColorsDataToClass() async {
  try {
    // 獲取當前執行檔案的目錄 (script)
    final scriptDir = File(Platform.script.toFilePath()).parent.path;
    logger.i('當前腳本目錄: $scriptDir');

    // 獲取專案根目錄 (從 script 到 root)
    final projectRootDir = Directory(scriptDir).parent.path;
    logger.i('專案根目錄: $projectRootDir');

    // 1. 讀取 color.dart 檔案內容
    final colorFilePath = '$projectRootDir/$_colorFilePath';
    final colorFile = File(colorFilePath);
    if (!colorFile.existsSync()) {
      logger.e('錯誤: 找不到 ${colorFile.path} 檔案');
      return;
    }

    logger.i('找到 color.dart 檔案: ${colorFile.path}');
    final String colorContent = await colorFile.readAsString();
    logger.i('成功讀取 color.dart 檔案，內容長度: ${colorContent.length} 字元');

    // 2. 解析檔案內容找到 colors map
    final colorsData = _extractColorsMapFromContent(colorContent);
    if (colorsData.isEmpty) {
      logger.e('錯誤: 無法從 ${colorFile.path} 找到 colors map 資料');
      return;
    }

    logger.i('成功從 color.dart 提取到 ${colorsData.length} 個顏色鍵名');

    // 3. 解析 outputFile 的路徑
    final outputFilePath = '$projectRootDir/$_colorFilePath';
    final outputFile = File(outputFilePath);
    logger.i('輸出檔案路徑: ${outputFile.path}');

    // 確保輸出目錄存在
    await outputFile.parent.create(recursive: true);

    // 4. 生成 AppColor 類內容
    final buffer = StringBuffer();

    buffer.writeln('class AppColor {');

    // 用來儲存合併的 gradient 鍵
    Map<String, List<String>> gradientColors = {};

    // 處理所有色彩鍵值
    for (var entry in colorsData.entries) {
      final key = entry.key;

      // 檢查鍵是否符合 gradient 的模式
      if (RegExp(r'_(gradient_\d+)$').hasMatch(key)) {
        // 提取 prefixName
        String baseKey = key.substring(0, key.lastIndexOf('_'));
        // 初始化列表
        gradientColors.putIfAbsent(baseKey, () => []);
        gradientColors[baseKey]!.add(key); // 將鍵添加到列表中
      } else {
        buffer.writeln('  static Color get $key => colors[\'$key\']!.themeColor;\n'); // 其他顏色鍵
      }
    }

    // 處理合併的 gradient 鍵
    gradientColors.forEach((baseKey, keys) {
      // 將鍵中的數字提取出來並排序
      keys.sort((a, b) {
        var numA = int.tryParse(a.split('_').last) ?? -1; // 提取數字，並給予預設值
        var numB = int.tryParse(b.split('_').last) ?? -1; // 提取數字，並給予預設值
        return numA.compareTo(numB); // 比較以進行排序
      });

      // 生成 List<Color> 的 getter
      buffer.writeln('  static List<Color> get $baseKey => [');
      for (var key in keys) {
        buffer.writeln('        colors[\'$key\']!.themeColor,'); // 將對應的 Color 加入列表
      }
      buffer.writeln('      ];\n');
    });

    final colorResult = '${buffer.toString().trimRight()}\n}';

    // 5. 確保輸出檔案存在
    if (!outputFile.existsSync()) {
      await outputFile.create(recursive: true);
      await outputFile.writeAsString('');
      logger.i('創建新檔案: ${outputFile.path}');
    }

    // 6. 讀取現有的 resource.dart 檔案
    String oldContent = await outputFile.readAsString();

    // 分割內容為行
    List<String> lines = oldContent.split('\n');

    // 找到 AppColor 類的行索引
    int startIndex = -1;
    int endIndex = -1;

    // 遍歷每一行尋找 AppColor 類
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('class AppColor')) {
        startIndex = i; // 記錄起始行索引
      }
      if (startIndex != -1 && lines[i].contains('{')) {
        startIndex = i; // 記錄開括號的行
        break; // 跳出這個循環，準備開始移除內容
      }
    }

    // 繼續尋找閉合的括號
    if (startIndex != -1) {
      int braceCount = 0; // 用於計算大括號的數量
      for (int i = startIndex; i < lines.length; i++) {
        if (lines[i].contains('{')) {
          braceCount++; // 遇到開括號
        }
        if (lines[i].contains('}')) {
          braceCount--; // 遇到閉括號
        }
        if (braceCount == 0) {
          endIndex = i; // 記錄閉合括號的行
          break;
        }
      }
    }

    // 7. 更新 AppColor 類
    if (startIndex != -1 && endIndex != -1) {
      logger.i('找到現有的 AppColor 類，位於行 $startIndex 到 $endIndex');
      lines.removeRange(startIndex, endIndex + 1);
      // 在原來的 startIndex 行插入新的 AppColor 類內容
      lines.insert(startIndex, colorResult);
    } else {
      logger.i('未找到現有的 AppColor 類，將添加到檔案末尾');
      // 如果沒有找到現有的 AppColor 類，則將新的類添加到檔案末尾
      lines.add(colorResult);
    }

    // 8. 將新內容寫回 resource.dart
    await outputFile.writeAsString(lines.join('\n'));

    logger.i('class AppColor 已成功更新到 ${outputFile.path}');
  } on StackTrace catch (e) {
    logger.e('錯誤堆疊: $e');
  } on Exception catch (e) {
    logger.e('執行過程中發生錯誤: $e');
  }
}

// 從檔案內容中提取 colors map
Map<String, dynamic> _extractColorsMapFromContent(String content) {
  try {
    // 查找 colors map 的開始位置
    final mapStart = content.indexOf('Map<String, ColorData> colors = {');
    if (mapStart == -1) {
      logger.e('無法找到 colors map 定義');
      return {};
    }

    logger.i('找到 colors map 定義，位置: $mapStart');

    // 找到開始位置後，提取整個 map
    int braceCount = 0;
    int currentPos = mapStart;

    // 找到第一個左大括號的位置
    while (currentPos < content.length && content[currentPos] != '{') {
      currentPos++;
    }

    // 如果找不到左大括號，返回空 map
    if (currentPos >= content.length) {
      logger.e('無法找到 colors map 的左大括號');
      return {};
    }

    int startPos = currentPos; // 記錄左大括號的位置
    logger.i('找到左大括號位置: $startPos');

    // 計算大括號配對，找到閉合的右大括號
    do {
      if (content[currentPos] == '{') {
        braceCount++;
      } else if (content[currentPos] == '}') {
        braceCount--;
      }
      currentPos++;
    } while (braceCount > 0 && currentPos < content.length);

    // 如果未找到匹配的右大括號，返回空 map
    if (braceCount != 0) {
      logger.e('colors map 大括號不匹配');
      return {};
    }

    logger.i('找到右大括號位置: ${currentPos - 1}');

    // 提取 map 內容
    final mapContent = content.substring(startPos, currentPos);
    logger.i('提取的 map 內容長度: ${mapContent.length} 字元');

    // 解析 map 內容
    return _parseColorsMap(mapContent);
  } on StackTrace catch (e) {
    logger.e('錯誤堆疊: $e');
  } on Exception catch (e) {
    logger.e('提取 colors map 時出錯: $e');
  }

  return {};
}

// 解析 colors map 字串，提取所有鍵
Map<String, dynamic> _parseColorsMap(String mapContent) {
  Map<String, dynamic> result = {};

  try {
    // 根據查看 color.dart 檔案的內容，每個鍵值對的模式應該是：
    // 'key_name': ColorData(...),
    final entryRegex = RegExp(r"'([^']+)':\s*ColorData\s*\([^{]*\{[^}]*\}[^)]*\),", multiLine: true);
    final matches = entryRegex.allMatches(mapContent);

    int count = 0;
    for (final match in matches) {
      if (match.groupCount >= 1) {
        final key = match.group(1)!;
        result[key] = null; // 我們只需要鍵名
        count++;
      }
    }

    logger.i('使用正則表達式從 colors map 中提取了 $count 個鍵名');

    // 如果沒有匹配到任何鍵，嘗試另一種正則表達式
    if (result.isEmpty) {
      logger.i('第一種正則表達式未匹配到鍵，嘗試第二種正則表達式');

      // 嘗試另一種正則表達式
      final simpleRegex = RegExp(r"'([^']+)':\s*ColorData\s*\(", multiLine: true);
      final simpleMatches = simpleRegex.allMatches(mapContent);

      for (final match in simpleMatches) {
        if (match.groupCount >= 1) {
          final key = match.group(1)!;
          result[key] = null;
          count++;
        }
      }

      logger.i('使用第二種正則表達式提取了 $count 個鍵名');
    }

    // 如果仍然沒有匹配到任何鍵，使用更簡單的方法
    if (result.isEmpty) {
      logger.i('正則表達式未能匹配到任何鍵，嘗試使用簡單分割方法');

      // 使用更簡單的方法嘗試提取鍵
      final lines = mapContent.split('\n');
      for (var line in lines) {
        // 查找包含 ColorData 的行
        if (line.contains('ColorData')) {
          // 查找單引號開始的鍵名
          final keyStart = line.indexOf("'");
          if (keyStart != -1) {
            // 提取鍵名
            final keyEnd = line.indexOf("'", keyStart + 1);
            if (keyEnd != -1) {
              final key = line.substring(keyStart + 1, keyEnd);
              if (key.isNotEmpty) {
                result[key] = null;
              }
            }
          }
        }
      }

      logger.i('使用簡單分割方法提取了 ${result.length} 個鍵名');
    }

    // 如果仍然沒有找到任何鍵，輸出部分 map 內容以便偵錯
    if (result.isEmpty) {
      logger.e('警告: 無法從 map 內容中提取任何鍵名');
      logger.d('map 內容預覽 (前200字元): ${mapContent.substring(0, min(200, mapContent.length))}');
    }
  } on StackTrace catch (e) {
    logger.e('錯誤堆疊: $e');
  } on Exception catch (e) {
    logger.e('解析 colors map 時出錯: $e');
  }

  return result;
}

// 取兩個數的最小值
int min(int a, int b) {
  return a < b ? a : b;
}

// 執行 dart format 格式化指定檔案
Future<void> _formatFile(String filePath) async {
  try {
    logger.i('正在格式化檔案: $filePath');

    // 執行 dart format 指令
    final result = await Process.run('dart', ['format', '--line-length', '150', filePath]);

    // 輸出結果
    if (result.exitCode == 0) {
      logger.i('格式化成功！');
      if (result.stdout.toString().trim().isNotEmpty) {
        logger.i(result.stdout);
      }
    } else {
      logger.i('格式化失敗，錯誤碼: ${result.exitCode}');
      logger.i(result.stderr);
    }
  } on Exception catch (e) {
    logger.e('格式化過程中發生錯誤: $e');
  }
}

Future<void> convertColors() async {
  await _convertColorsDataToClass();
  await _formatFile(_colorFilePath);
  logger.i('顏色轉換結束');
}
