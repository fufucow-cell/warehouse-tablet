import 'package:flutter/material.dart';

class TempRouterUtil {
  // MARK: - Properties

  static BuildContext? _cachedRootContext;

  // MARK: - Public Methods

  static BuildContext? getRootContext([
    BuildContext? context,
  ]) {
    if (_cachedRootContext != null) {
      return _cachedRootContext;
    }

    // 如果 _cachedRootContext == null 且提供了 context，執行初始化
    if (context != null) {
      _initializeFromContext(context);
      return _cachedRootContext;
    }

    return null;
  }

  /// 清除緩存的 root context（用於測試或重置）
  static void clear() {
    _cachedRootContext = null;
  }

  // MARK: - Private Methods

  static void _initializeFromContext(BuildContext context) {
    if (_cachedRootContext != null) {
      return;
    }

    try {
      final rootNavigator =
          Navigator.maybeOf(context, rootNavigator: true);
      if (rootNavigator != null) {
        _cachedRootContext = rootNavigator.context;
        return;
      }

      BuildContext? currentContext = context;
      while (currentContext != null) {
        final materialApp = currentContext
            .findAncestorWidgetOfExactType<MaterialApp>();
        if (materialApp != null) {
          final navigator = Navigator.maybeOf(
            currentContext,
            rootNavigator: true,
          );
          if (navigator != null) {
            _cachedRootContext = navigator.context;
            return;
          }
          _cachedRootContext = currentContext;
          return;
        }
        // 向上查找父 widget
        final parent =
            currentContext.findAncestorStateOfType<State>();
        if (parent != null && parent.mounted) {
          currentContext = parent.context;
        } else {
          break;
        }
      }
    } on Object {
      _cachedRootContext ??= context;
      rethrow;
    }

    _cachedRootContext ??= context;
  }
}
