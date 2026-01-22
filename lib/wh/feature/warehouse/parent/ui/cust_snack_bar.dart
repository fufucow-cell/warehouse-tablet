import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class CustSnackBar {
  static OverlayEntry? _currentOverlayEntry;

  static void show({
    BuildContext? context,
    String? title,
    String? message,
  }) {
    // 先移除之前的 Overlay
    _removeOverlay();

    final ctx = context ?? RouterService.instance.getRootNavigatorContext;
    if (ctx == null) {
      return;
    }

    // 使用多層延遲確保在 Dialog 完全渲染後再插入
    // 1. 先等待當前幀完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 2. 再等待一個 microtask，確保 Dialog 的 OverlayEntry 已經插入
      Future.microtask(() {
        // 3. 再等待一個短延遲，確保 Dialog 完全渲染
        Future.delayed(const Duration(milliseconds: 200), () {
          // 獲取根 Navigator 的 Overlay，確保使用最上層的 Overlay
          final navigator = Navigator.of(ctx, rootNavigator: true);
          final overlay = navigator.overlay;

          if (overlay == null) {
            return;
          }

          _currentOverlayEntry = OverlayEntry(
            maintainState: false,
            opaque: false,
            builder: (context) => _OverlaySnackBar(
              title: title,
              message: message,
              onDismiss: _removeOverlay,
            ),
          );

          // 插入到 Overlay 的最上層（最後插入的會顯示在最上層）
          overlay.insert(_currentOverlayEntry!);

          // 3 秒後自動移除
          Future.delayed(const Duration(seconds: 3), () {
            _removeOverlay();
          });
        });
      });
    });
  }

  /// 移除 Overlay
  static void _removeOverlay() {
    _currentOverlayEntry?.remove();
    _currentOverlayEntry = null;
  }

  static void close(BuildContext? context) {
    _removeOverlay();
  }
}

/// Overlay SnackBar Widget（用於在 Dialog 上顯示）
class _OverlaySnackBar extends StatefulWidget {
  final String? title;
  final String? message;
  final VoidCallback onDismiss;

  const _OverlaySnackBar({
    this.title,
    this.message,
    required this.onDismiss,
  });

  @override
  State<_OverlaySnackBar> createState() => _OverlaySnackBarState();
}

class _OverlaySnackBarState extends State<_OverlaySnackBar> {
  @override
  void initState() {
    super.initState();
    // 3 秒後自動關閉
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0.scale,
      left: 16.0.scale,
      right: 16.0.scale,
      child: Material(
        elevation: 1000,
        color: Colors.transparent,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            // 支持左右滑動關閉
            widget.onDismiss();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.0.scale,
                  vertical: 20.0.scale,
                ),
                decoration: BoxDecoration(
                  color: EnumColor.backgroundSecondary.color,
                  borderRadius: BorderRadius.circular(20.0.scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0.scale,
                      offset: Offset(0, 10.0.scale),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustTextWidget(
                      widget.title ?? '',
                      size: 32.0.scale,
                      weightType: EnumFontWeightType.bold,
                    ),
                    if (widget.message?.isNotEmpty ?? false) ...[
                      SizedBox(height: 16.0.scale),
                      CustTextWidget(
                        widget.message ?? '',
                        size: 28.0.scale,
                        color: EnumColor.textSecondary.color,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
