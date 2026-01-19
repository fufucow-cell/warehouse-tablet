import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouterService extends GetxService {
  // MARK: - Properties

  final _model = RouterServiceModel();
  static const String _tagName = 'warehouse';
  static RouterService get instance => Get.find<RouterService>(tag: _tagName);
  BuildContext? get getRootNavigatorContext => _model.rootNavigatorContext;
  BuildContext? get getNestedNavigatorContext => _model.nestedNavigatorContext;

  // MARK: - Init

  RouterService._internal();

  static RouterService register() {
    if (Get.isRegistered<RouterService>(tag: _tagName)) {
      return instance;
    }
    final RouterService service = RouterService._internal();
    Get.put<RouterService>(
      service,
      tag: _tagName,
      permanent: true,
    );
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<RouterService>(tag: _tagName)) {
      instance._model.rootNavigatorContext = null;
      instance._model.nestedNavigatorContext = null;
      Get.delete<RouterService>(
        tag: _tagName,
        force: true,
      );
    }
  }

  // MARK: - Public Method

  BuildContext? findNestedNavigatorContext(BuildContext context) {
    if (_model.nestedNavigatorContext != null) {
      return _model.nestedNavigatorContext;
    }

    try {
      // 先查找最近的 Navigator（可能是 Nested 或 Root）
      final nearestNavigator = Navigator.maybeOf(context);
      if (nearestNavigator != null) {
        // 检查是否是 Root Navigator
        final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);
        // 如果最近的 Navigator 不是 Root Navigator，说明是 Nested Navigator
        if (nearestNavigator != rootNavigator) {
          _model.nestedNavigatorContext = nearestNavigator.context;
          return _model.nestedNavigatorContext;
        }
      }
    } on Object {
      return null;
    }

    return null;
  }

  BuildContext? findRootNavigatorContext(BuildContext context) {
    if (_model.rootNavigatorContext != null) {
      return _model.rootNavigatorContext;
    }

    try {
      final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);
      if (rootNavigator != null) {
        _model.rootNavigatorContext = rootNavigator.context;
        return _model.rootNavigatorContext;
      }

      BuildContext? currentContext = context;
      while (currentContext != null) {
        final materialApp = currentContext.findAncestorWidgetOfExactType<MaterialApp>();
        if (materialApp != null) {
          final navigator = Navigator.maybeOf(
            currentContext,
            rootNavigator: true,
          );
          if (navigator != null) {
            _model.rootNavigatorContext = navigator.context;
            return _model.rootNavigatorContext;
          }
          _model.rootNavigatorContext = currentContext;
          return _model.rootNavigatorContext;
        }
        // 向上查找父 widget
        final parent = currentContext.findAncestorStateOfType<State>();
        if (parent != null && parent.mounted) {
          currentContext = parent.context;
        } else {
          break;
        }
      }
    } on Object {
      return null;
    }

    return null;
  }
}
