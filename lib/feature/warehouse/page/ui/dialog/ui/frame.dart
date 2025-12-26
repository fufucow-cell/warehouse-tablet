import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class DialogFrame extends StatelessWidget {
  final Widget child;
  final DialogHeader header;
  final Widget? footer;
  final double? width;
  final double? maxHeight;
  final double? minHeight;

  const DialogFrame({
    super.key,
    required this.child,
    required this.header,
    this.footer,
    this.width,
    this.maxHeight,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    const defaultWidth = 720.0;
    const defaultMinHeight = 430.0;
    const defaultMaxHeight = 1072.0;

    // 使用固定宽度，高度自由伸展
    final fixedWidth = width ?? defaultWidth.scale;

    return Dialog(
      insetPadding: EdgeInsets.all(30.0.scale),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: (minHeight ?? defaultMinHeight).scale,
          maxHeight: (maxHeight ?? defaultMaxHeight).scale,
        ),
        child: Container(
          width: fixedWidth,
          decoration: BoxDecoration(
            color: EnumColor.backgroundPrimary.color,
            borderRadius: BorderRadius.circular(24.0.scale),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: (maxHeight ?? defaultMaxHeight).scale,
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 56.0.scale,
                        vertical: 32.0.scale,
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
              footer ??
                  DialogFooter(
                    type: DialogFooterType.onlyConfirm,
                    onConfirm: () => Navigator.of(context).pop(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
