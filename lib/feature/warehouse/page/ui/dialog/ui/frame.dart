import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';

class DialogFrame extends StatelessWidget {
  final Widget child;
  final DialogHeader header;
  final DialogFooter? footer;
  final double? maxWidth;
  final double? minWidth;
  final double? maxHeight;
  final double? minHeight;

  const DialogFrame({
    super.key,
    required this.child,
    required this.header,
    this.footer,
    this.maxWidth,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    const defaultMinWidth = 720.0;
    const defaultMinHeight = 430.0;
    const defaultMaxWidth = 1168.0;
    const defaultMaxHeight = 1072.0;

    return Dialog(
      insetPadding: EdgeInsets.all(30.0.scale),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth ?? defaultMinWidth.scale,
          minHeight: minHeight ?? defaultMinHeight.scale,
          maxWidth: maxWidth ?? defaultMaxWidth.scale,
          maxHeight: maxHeight ?? defaultMaxHeight.scale,
        ),
        child: Container(
          width: minWidth ?? defaultMinWidth.scale,
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
