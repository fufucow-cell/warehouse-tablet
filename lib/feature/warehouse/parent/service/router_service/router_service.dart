import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/router_service/router_service_model.dart';
import 'package:get/get.dart';

class RouterService extends GetxService {
  // MARK: - Properties

  final _model = RouterServiceModel();
  static RouterService get instance => Get.find<RouterService>();

  // MARK: - Init

  RouterService._internal();

  static RouterService register() {
    if (Get.isRegistered<RouterService>()) {
      return Get.find<RouterService>();
    }
    final RouterService service = RouterService._internal();
    Get.put<RouterService>(service, permanent: true);
    return service;
  }

  static void unregister() {
    if (Get.isRegistered<RouterService>()) {
      Get.delete<RouterService>(force: true);
    }
  }

  // MARK: - Public Method

  BuildContext? getRootContext([
    BuildContext? context,
  ]) {
    if (_model.cachedRootContext != null) {
      return _model.cachedRootContext;
    }

    // 如果 cachedRootContext == null 且提供了 context，執行初始化
    if (context != null) {
      _initializeFromContext(context);
      return _model.cachedRootContext;
    }

    return null;
  }

  /// 設置 root context
  void setRootContext(BuildContext? context) {
    _model.cachedRootContext = context;
  }

  /// 清除緩存的 root context（用於測試或重置）
  void clear() {
    _model.cachedRootContext = null;
  }

  // MARK: - Private Method

  void _initializeFromContext(BuildContext context) {
    if (_model.cachedRootContext != null) {
      return;
    }

    try {
      final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);
      if (rootNavigator != null) {
        _model.cachedRootContext = rootNavigator.context;
        return;
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
            _model.cachedRootContext = navigator.context;
            return;
          }
          _model.cachedRootContext = currentContext;
          return;
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
      _model.cachedRootContext ??= context;
      rethrow;
    }

    _model.cachedRootContext ??= context;
  }
}
