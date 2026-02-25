// ignore_for_file: avoid_print

import 'dart:io';

// Global variables
String _featureFileName = '';
String _pageFileName = '';
String _featureClassName = '';
String _pageClassName = '';

void main(List<String> args) {
  if (args.length != 2) {
    print('使用方法: dart create_mvc_struct.dart <feature_name> <page_name>');
    print('範例: dart create_mvc_struct.dart bank_record main');
    exit(1);
  }

  _featureFileName = args[0];
  _pageFileName = args[1];
  _featureClassName = _toPascalCase(_featureFileName);
  _pageClassName = _toPascalCase(_pageFileName);

  print('開始創建 MVC 結構...');
  print('Feature: $_featureFileName ($_featureClassName)');
  print('Page: $_pageFileName ($_pageClassName)');

  _createPageFolder();
}

String _toPascalCase(String input) {
  return input.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join('');
}

bool _createDirectory(String path) {
  final directory = Directory(path);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
    print('創建目錄: $path');
    return true;
  } else {
    print('目錄已存在: $path');
    return false;
  }
}

bool _createFile(String path) {
  final file = File(path);
  if (!file.existsSync()) {
    file.createSync();
    print('創建檔案: $path');
    return true;
  } else {
    print('檔案已存在: $path');
    return false;
  }
}

void _createPageFolder() {
  String featureDirectoryPath = 'lib/wh/feature/$_featureFileName';
  String pageDirectoryPath = '$featureDirectoryPath/page/$_pageFileName';
  String filePath = '$pageDirectoryPath/${_featureFileName}_${_pageFileName}';
  String pageFilePath = '${filePath}_page.dart';
  String pageModelFilePath = '${filePath}_page_model.dart';
  String pageControllerFilePath = '${filePath}_page_controller.dart';

  // 檢查 page 目錄是否存在
  final pageDirectory = Directory(pageDirectoryPath);
  if (pageDirectory.existsSync()) {
    print('錯誤: Page 目錄已存在: $pageDirectoryPath');
    print('操作停止，請使用不同的 page name');
    exit(1);
  }

  // 檢查 feature 目錄是否存在
  final featureDirectory = Directory(featureDirectoryPath);
  bool featureExists = featureDirectory.existsSync();

  if (!featureExists) {
    print('創建 Feature 目錄: $featureDirectoryPath');
  } else {
    print('Feature 目錄已存在: $featureDirectoryPath');
  }

  // 創建完整的 page 目錄路徑 (包含中間的 page 目錄)
  pageDirectory.createSync(recursive: true);
  print('創建 Page 目錄: $pageDirectoryPath');

  // 創建檔案
  String pageInteractiveFilePath = '${filePath}_page_interactive.dart';
  String pageRouteFilePath = '${filePath}_page_route.dart';

  _createFile(pageFilePath);
  _createPageContent(pageFilePath);

  _createFile(pageModelFilePath);
  _createPageModelContent(pageModelFilePath);

  _createFile(pageControllerFilePath);
  _createPageControllerContent(pageControllerFilePath);

  _createFile(pageInteractiveFilePath);
  _createPageInteractiveContent(pageInteractiveFilePath);

  _createFile(pageRouteFilePath);
  _createPageRouteContent(pageRouteFilePath);

  print('');
  print('✅ MVC 結構創建完成!');
  print('📁 路徑: $pageDirectoryPath');
  print('📄 檔案:');
  print('   - ${_featureFileName}_${_pageFileName}_page.dart');
  print('   - ${_featureFileName}_${_pageFileName}_page_model.dart');
  print('   - ${_featureFileName}_${_pageFileName}_page_controller.dart');
  print('   - ${_featureFileName}_${_pageFileName}_page_interactive.dart');
  print('   - ${_featureFileName}_${_pageFileName}_page_route.dart');
}

void _createPageContent(String path) {
  // 计算 controller 文件的导入路径
  String controllerImportPath =
      'package:engo_terminal_app3/wh/feature/$_featureFileName/page/$_pageFileName/${_featureFileName}_${_pageFileName}_page_controller.dart';
  String content = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '$controllerImportPath';

class $_featureClassName${_pageClassName}Page extends GetView<$_featureClassName${_pageClassName}PageController> {
  const $_featureClassName${_pageClassName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<$_featureClassName${_pageClassName}PageController>(
      init: $_featureClassName${_pageClassName}PageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Title'),
          ),
          body: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<$_featureClassName${_pageClassName}PageController>();

    return Container();
  }
}
''';

  File(path).writeAsStringSync(content.trim());
  // ignore: avoid_print
  print('初始化頁面檔案內容: $path');
}

void _createPageModelContent(String path) {
  String content = '''
class $_featureClassName${_pageClassName}PageModel {}
''';

  File(path).writeAsStringSync(content.trim());
  print('初始化頁面模組檔案內容: $path');
}

void _createPageControllerContent(String path) {
  // Controller 导入 model，并使用 part 包含 interactive 和 route
  String modelImportPath =
      'package:engo_terminal_app3/wh/feature/$_featureFileName/page/$_pageFileName/${_featureFileName}_${_pageFileName}_page_model.dart';
  String content = '''
import 'package:get/get.dart';
import '$modelImportPath';

part '${_featureFileName}_${_pageFileName}_page_interactive.dart';
part '${_featureFileName}_${_pageFileName}_page_route.dart';

class $_featureClassName${_pageClassName}PageController extends GetxController {
  // MARK: - Properties

  final _model = $_featureClassName${_pageClassName}PageModel();

  // MARK: - Init

  $_featureClassName${_pageClassName}PageController();

  // MARK: - Methods
}
''';

  File(path).writeAsStringSync(content.trim());
  print('初始化頁面控制器檔案內容: $path');
}

void _createPageInteractiveContent(String path) {
  String content = '''
part of '${_featureFileName}_${_pageFileName}_page_controller.dart';

enum Enum$_featureClassName${_pageClassName}PageInteractive {
  tapSomeWidget,
}

extension $_featureClassName${_pageClassName}PageUserEventExtension on $_featureClassName${_pageClassName}PageController {
  Future<void> _interactive(Enum$_featureClassName${_pageClassName}PageInteractive type, {dynamic data}) async {
    switch (type) {
      case Enum$_featureClassName${_pageClassName}PageInteractive.tapSomeWidget:
        break;
    }
  }
}
''';

  File(path).writeAsStringSync(content.trim());
  print('初始化頁面互動檔案內容: $path');
}

void _createPageRouteContent(String path) {
  String content = '''
part of '${_featureFileName}_${_pageFileName}_page_controller.dart';

enum Enum$_featureClassName${_pageClassName}PageRoute {
  goOtherPage,
  showSomeDialog,
}

extension $_featureClassName${_pageClassName}PageRouteExtension on $_featureClassName${_pageClassName}PageController {
  Future<void> _routerHandle(Enum$_featureClassName${_pageClassName}PageRoute type, {dynamic data}) async {
    switch (type) {
      case Enum$_featureClassName${_pageClassName}PageRoute.goOtherPage:
        break;
      case Enum$_featureClassName${_pageClassName}PageRoute.showSomeDialog:
        break;
    }
  }
}
''';

  File(path).writeAsStringSync(content.trim());
  print('初始化頁面路由檔案內容: $path');
}
