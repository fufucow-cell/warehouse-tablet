// ignore_for_file: avoid_print

import 'dart:io';

// Global variables
String _featureFileName = '';
String _pageFileName = '';
String _featureClassName = '';
String _pageClassName = '';

void main(List<String> args) {
  if (args.length != 2) {
    print('使用方法: dart link_mvc_router.dart <feature_name> <page_name>');
    print('範例: dart link_mvc_router.dart bank_record main');
    exit(1);
  }

  _featureFileName = args[0];
  _pageFileName = args[1];
  _featureClassName = _toPascalCase(_featureFileName);
  _pageClassName = _toPascalCase(_pageFileName);

  print('開始建立 Router 連結...');
  print('Feature: $_featureFileName ($_featureClassName)');
  print('Page: $_pageFileName ($_pageClassName)');

  _linkRouter();
}

String _toPascalCase(String input) {
  return input.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join('');
}

void _linkRouter() {
  // 模块路由文件放在 feature 目录下
  String moduleRouterPath = 'lib/feature/$_featureFileName/router/${_featureFileName}_router.dart';
  // 主路由桥接文件
  String filePath = 'lib/router/app_router_$_featureFileName.dart';
  bool isNewFeature = !File(filePath).existsSync();
  bool isNewModuleRouter = !File(moduleRouterPath).existsSync();

  // 1. 創建或更新模組內的路由文件
  _createOrUpdateModuleRouter(moduleRouterPath);

  // 2. 創建或更新主路由橋接文件
  _createOrUpdateAppRouterFeature(filePath, moduleRouterPath, isNewModuleRouter);

  // 3. 更新路由常量文件（模块内的）
  _updateRouterConstant();

  print('');
  print('✅ Router 連結完成!');
  print('📁 檔案更新:');
  print('   - lib/feature/$_featureFileName/router/${_featureFileName}_router.dart');
  print('   - lib/router/app_router_$_featureFileName.dart');
  print('   - lib/feature/$_featureFileName/router/${_featureFileName}_router_constant.dart');
}

void _createOrUpdateModuleRouter(String moduleRouterPath) {
  String routerName = '${_featureFileName.toUpperCase()}_${_pageFileName.toUpperCase()}';
  
  // 确保 router 目录存在
  Directory(moduleRouterPath.substring(0, moduleRouterPath.lastIndexOf('/'))).createSync(recursive: true);
  
  File file = File(moduleRouterPath);

  if (!file.existsSync()) {
    // 創建新的 router 檔案
    String content = '''import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/$_featureFileName/page/$_pageFileName/${_featureFileName}_${_pageFileName}_page.dart';
import 'package:flutter_smart_home_tablet/feature/$_featureFileName/router/${_featureFileName}_router_constant.dart';
import 'package:flutter_smart_home_tablet/router/app_router_util.dart' as app_router_util;

class ${_featureClassName}Router {
  static Route<T>? generateRoute<T>(RouteSettings settings) {
    switch (settings.name) {
      case ${_featureClassName}RouterConstant.$routerName:
        return app_router_util.buildTransitionRoute(
          name: settings.name,
          child: $_featureClassName${_pageClassName}Page(),
        );
    }
    return null;
  }
}''';
    file.writeAsStringSync(content);
    print('創建新的模組 Router 檔案: $moduleRouterPath');
  } else {
    // 更新現有的 router 檔案
    String content = file.readAsStringSync();

    // 檢查是否已經有這個 case（精確匹配）
    String exactCaseMatch = "case ${_featureClassName}RouterConstant.$routerName:";
    if (content.contains(exactCaseMatch)) {
      print('Router case 已存在: $routerName');
      return;
    }

    // 檢查並添加路由常量 import
    String constantImportLine = "import 'package:flutter_smart_home_tablet/feature/$_featureFileName/router/${_featureFileName}_router_constant.dart';";
    if (!content.contains(constantImportLine)) {
      // 找到最後一個 import，在其後添加
      int lastImportIndex = content.lastIndexOf("import 'package:");
      if (lastImportIndex != -1) {
        int lineEnd = content.indexOf('\n', lastImportIndex);
        content = content.substring(0, lineEnd + 1) + constantImportLine + '\n' + content.substring(lineEnd + 1);
      }
    }

    // 檢查是否已經有這個 import
    String importLine = "import 'package:flutter_smart_home_tablet/feature/$_featureFileName/page/$_pageFileName/${_featureFileName}_${_pageFileName}_page.dart';";
    if (!content.contains(importLine)) {
      // 找到最後一個同 feature 的 import，或者最後一個 module import
      RegExp moduleImportPattern = RegExp(r"import 'package:flutter_smart_home_tablet/feature/$_featureFileName/");
      Iterable<Match> matches = moduleImportPattern.allMatches(content);

      int insertIndex;
      if (matches.isNotEmpty) {
        // 找到最後一個同 feature 的 import
        Match lastMatch = matches.last;
        insertIndex = content.indexOf('\n', lastMatch.end) + 1;
      } else {
        // 找到最後一個 module import
        int lastModuleImportIndex = content.lastIndexOf("import 'package:flutter_smart_home_tablet/feature/");
        if (lastModuleImportIndex != -1) {
          insertIndex = content.indexOf('\n', lastModuleImportIndex) + 1;
        } else {
          // 找到 material.dart import 後插入
          int materialImportIndex = content.indexOf("import 'package:flutter/material.dart';");
          insertIndex = content.indexOf('\n', materialImportIndex) + 1;
        }
      }

      content = content.substring(0, insertIndex) + importLine + '\n' + content.substring(insertIndex);
    }

    // 添加新的 case
    String newCase = '''
      case ${_featureClassName}RouterConstant.$routerName:
        return app_router_util.buildTransitionRoute(
          name: settings.name,
          child: $_featureClassName${_pageClassName}Page(),
        );''';

    // 找到 switch 的結尾並插入新 case
    int switchEndIndex = content.lastIndexOf('    }');
    if (switchEndIndex != -1) {
      content = content.substring(0, switchEndIndex) + newCase + '\n' + content.substring(switchEndIndex);
    }

    file.writeAsStringSync(content);
    print('在現有模組 Router 檔案中添加新的 Page: $routerName');
  }
}

void _createOrUpdateAppRouterFeature(String filePath, String moduleRouterPath, bool isNewModuleRouter) {
  File file = File(filePath);
  String moduleRouterClassName = '${_featureClassName}Router';
  
  if (!file.existsSync() || isNewModuleRouter) {
    // 創建新的主路由橋接檔案
    String content = '''import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/$_featureFileName/router/${_featureFileName}_router.dart';

/// App Router for $_featureClassName
/// 
/// 这个文件是主应用的路由桥接，引用 $_featureFileName 模块内的路由
class AppRouter$_featureClassName {
  static Route<T>? generateRoute<T>(RouteSettings settings) {
    // 委托给 $_featureFileName 模块内的路由处理
    return $moduleRouterClassName.generateRoute<T>(settings);
  }
}''';
    file.writeAsStringSync(content);
    print('創建新的主路由橋接檔案: $filePath');
  } else {
    print('主路由橋接檔案已存在: $filePath');
  }
}

void _updateRouterConstant() {
  // 模块路由常量文件
  String filePath = 'lib/feature/$_featureFileName/router/${_featureFileName}_router_constant.dart';
  String routerName = '${_featureFileName.toUpperCase()}_${_pageFileName.toUpperCase()}';
  String routerConstant = "  static const String $routerName = '${_featureFileName}_${_pageFileName}';";

  File file = File(filePath);
  
  // 确保目录存在
  Directory(file.parent.path).createSync(recursive: true);

  if (!file.existsSync()) {
    // 創建新的路由常量文件
    String content = '''// ignore_for_file: constant_identifier_names

/// $_featureClassName 模块路由常量
/// 
/// 包含 $_featureClassName 模块的子页面路由
/// 此文件属于 $_featureFileName 模块，可以随模块一起复制
class ${_featureClassName}RouterConstant {
  // $_featureClassName 子页面
$routerConstant
}
''';
    file.writeAsStringSync(content);
    print('創建新的模組路由常量檔案: $filePath');
  } else {
    // 更新現有的路由常量文件
    String content = file.readAsStringSync();

    // 檢查是否已經存在（精確匹配）
    String exactMatch = "static const String $routerName = ";
    if (content.contains(exactMatch)) {
      print('Router 名稱已存在: $routerName');
      return;
    }

    // 找到最後一個 static const String 並在其後添加
    int lastConstIndex = content.lastIndexOf('static const String');
    if (lastConstIndex != -1) {
      int lineEnd = content.indexOf('\n', lastConstIndex);
      content = content.substring(0, lineEnd + 1) + routerConstant + '\n' + content.substring(lineEnd + 1);
      file.writeAsStringSync(content);
      print('添加 Router 名稱: $routerName');
    }
  }
}
