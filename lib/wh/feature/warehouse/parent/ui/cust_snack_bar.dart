import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/router_service/router_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';

class CustSnackBar {
  static void show({
    BuildContext? context,
    String? title,
    String? message,
  }) {
    final ctx = context ?? RouterService.instance.getRootNavigatorContext;
    if (ctx == null) {
      return;
    }

    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.all(16.0.scale),
        dismissDirection: DismissDirection.horizontal,
        content: Row(
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
                    title ?? '',
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.bold,
                  ),
                  if (message?.isNotEmpty ?? false) ...[
                    SizedBox(height: 16.0.scale),
                    CustTextWidget(
                      message ?? '',
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
    );
  }

  static void close(BuildContext? context) {
    final ctx = context ?? RouterService.instance.getRootNavigatorContext;
    if (ctx == null) {
      return;
    }
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  }
}
