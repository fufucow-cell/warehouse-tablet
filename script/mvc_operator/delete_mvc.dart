// ignore_for_file: avoid_print

import 'dart:io';

// Global variables
String _featureFileName = '';
String _pageFileName = '';
String _featureClassName = '';
String _pageClassName = '';

void main(List<String> args) {
  if (args.length != 2) {
    print('使用方法: dart delete_mvc.dart <feature_name> <page_name>');
    print('範例: dart delete_mvc.dart bank_record currency');
    exit(1);
  }

  _featureFileName = args[0];
  _pageFileName = args[1];
  _featureClassName = _toPascalCase(_featureFileName);
  _pageClassName = _toPascalCase(_pageFileName);

  print('開始刪除 MVC 結構...');
  print('Feature: $_featureFileName ($_featureClassName)');
  print('Page: $_pageFileName ($_pageClassName)');
  print('');

  _deleteMVCStructure();
}

String _toPascalCase(String input) {
  return input.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join('');
}

void _deleteMVCStructure() {
  // 1. 刪除頁面目錄
  _deletePageFolder();

  // 2. 檢查並刪除空的 feature folder
  _checkAndDeleteEmptyFeatureFolder();

  // 3. 從 Router 中移除相關配置
  _removeFromAppRouter();

  // 4. 從 app_router_name.dart 中移除路由名稱
  _removeFromAppRouterName();

  // 5. 檢查是否需要刪除整個 feature router
  _checkAndCleanupFeatureRouter();

  print('');
  print('✅ MVC 結構刪除完成!');
}

void _deletePageFolder() {
  String pageDirectoryPath = 'lib/feature/$_featureFileName/page/$_pageFileName';
  Directory pageDirectory = Directory(pageDirectoryPath);

  if (!pageDirectory.existsSync()) {
    print('📁 頁面目錄不存在: $pageDirectoryPath');
    return;
  }

  try {
    pageDirectory.deleteSync(recursive: true);
    print('✅ 已刪除頁面目錄: $pageDirectoryPath');
  } catch (e) {
    print('❌ 刪除頁面目錄失敗: $e');
  }
}

void _checkAndDeleteEmptyFeatureFolder() {
  String featureDirectoryPath = 'lib/feature/$_featureFileName';
  Directory featureDirectory = Directory(featureDirectoryPath);

  if (!featureDirectory.existsSync()) {
    return;
  }

  try {
    // 檢查 feature folder 下的 page 目錄是否為空
    String pageDirectoryPath = '$featureDirectoryPath/page';
    Directory pageDirectory = Directory(pageDirectoryPath);

    if (pageDirectory.existsSync()) {
      List<FileSystemEntity> pageContents = pageDirectory.listSync();
      if (pageContents.isEmpty) {
        // page 目錄為空，刪除整個 feature folder
        featureDirectory.deleteSync(recursive: true);
        print('✅ 已刪除空的 Feature 目錄: $featureDirectoryPath');
        return;
      }
    } else {
      // page 目錄不存在，檢查 feature folder 是否為空
      List<FileSystemEntity> featureContents = featureDirectory.listSync();
      if (featureContents.isEmpty) {
        featureDirectory.deleteSync(recursive: true);
        print('✅ 已刪除空的 Feature 目錄: $featureDirectoryPath');
      }
    }
  } catch (e) {
    print('❌ 檢查 Feature 目錄失敗: $e');
  }
}

void _removeFromAppRouter() {
  String filePath = 'lib/router/app_router_$_featureFileName.dart';
  String routerName = '${_featureFileName.toUpperCase()}_${_pageFileName.toUpperCase()}';

  File file = File(filePath);
  if (!file.existsSync()) {
    print('🔗 Router 檔案不存在: $filePath');
    return;
  }

  try {
    String content = file.readAsStringSync();

    // 移除 import
    String importLine = "import 'package:flutter_smart_home_tablet/feature/$_featureFileName/page/$_pageFileName/${_featureFileName}_${_pageFileName}_page.dart';";
    content = content.replaceAll(importLine + '\n', '');

    // 移除 case 區塊
    RegExp casePattern = RegExp(
      r'\s*case AppRouterName\.' + routerName + r':.*?;',
      multiLine: true,
      dotAll: true,
    );
    content = content.replaceAll(casePattern, '');

    file.writeAsStringSync(content);
    print('✅ 已從 Router 檔案移除: $routerName');
  } catch (e) {
    print('❌ 移除 Router 配置失敗: $e');
  }
}

void _removeFromAppRouterName() {
  String filePath = 'lib/router/app_router_name.dart';
  String routerName = '${_featureFileName.toUpperCase()}_${_pageFileName.toUpperCase()}';

  File file = File(filePath);
  if (!file.existsSync()) {
    print('🔗 app_router_name.dart 不存在');
    return;
  }

  try {
    String content = file.readAsStringSync();
    String routerConstant = "  static const String $routerName = '${_featureFileName}_${_pageFileName}';";

    content = content.replaceAll(routerConstant + '\n', '');

    file.writeAsStringSync(content);
    print('✅ 已從 app_router_name.dart 移除: $routerName');
  } catch (e) {
    print('❌ 移除路由名稱失敗: $e');
  }
}

void _checkAndCleanupFeatureRouter() {
  String filePath = 'lib/router/app_router_$_featureFileName.dart';
  File file = File(filePath);

  if (!file.existsSync()) {
    return;
  }

  try {
    String content = file.readAsStringSync();

    // 檢查是否還有其他 case
    RegExp casePattern = RegExp(r'case AppRouterName\..*?:', multiLine: true);
    Iterable<Match> matches = casePattern.allMatches(content);

    if (matches.isEmpty) {
      // 沒有其他 case，可以刪除整個 feature router
      file.deleteSync();
      print('✅ 已刪除空的 Feature Router: $filePath');

      // 從主 app_router.dart 中移除引用
      _removeFeatureFromMainRouter();
    } else {
      print('📝 Feature Router 還有其他頁面，保留檔案: $filePath');
    }
  } catch (e) {
    print('❌ 檢查 Feature Router 失敗: $e');
  }
}

void _removeFeatureFromMainRouter() {
  String filePath = 'lib/router/app_router.dart';
  File file = File(filePath);

  if (!file.existsSync()) {
    return;
  }

  try {
    String content = file.readAsStringSync();

    // 移除 import
    String importLine = "import 'package:flutter_smart_home_tablet/router/app_router_$_featureFileName.dart' deferred as app_router_$_featureFileName;";
    content = content.replaceAll(importLine + '\n', '');

    // 移除 loadLibrary
    String loadLibraryLine = "      app_router_$_featureFileName.loadLibrary(),";
    content = content.replaceAll(loadLibraryLine + '\n', '');

    // 移除 generateRoute
    String generateRouteLine = "      app_router_$_featureFileName.AppRouter$_featureClassName.generateRoute<T>(settings) ?? // $_featureFileName router";
    content = content.replaceAll(generateRouteLine + '\n', '');

    file.writeAsStringSync(content);
    print('✅ 已從主 Router 移除 Feature 引用: $_featureFileName');
  } catch (e) {
    print('❌ 從主 Router 移除失敗: $e');
  }
}