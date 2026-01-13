import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouterService extends GetxService {
  // MARK: - Properties

  final _model = RouterServiceModel();
  static const String _tagName = 'warehouse';
  static RouterService get instance => Get.find<RouterService>(tag: _tagName);
  BuildContext? get getNavigatorContext => _model.navigatorContext;

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
      instance._model.navigatorContext = null;
      Get.delete<RouterService>(
        tag: _tagName,
        force: true,
      );
    }
  }

  // MARK: - Public Method

  void findNavigatorContext(BuildContext context) {
    if (_model.navigatorContext != null) {
      return;
    }

    try {
      final rootNavigator = Navigator.maybeOf(context, rootNavigator: true);
      if (rootNavigator != null) {
        _model.navigatorContext = rootNavigator.context;
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
            _model.navigatorContext = navigator.context;
            return;
          }
          _model.navigatorContext = currentContext;
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
      _model.navigatorContext ??= context;
      rethrow;
    }

    _model.navigatorContext ??= context;
  }
}
