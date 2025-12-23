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
  final double? maxHeight;

  const DialogFrame({
    super.key,
    required this.child,
    required this.header,
    this.footer,
    this.maxWidth,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    const minWidth = 962.0;
    const minHeight = 1024.0;

    return Dialog(
      insetPadding: EdgeInsets.all(30.0.scale),
      child: Container(
        width: minWidth.scale,
        height: minHeight.scale,
        constraints: BoxConstraints(
          maxWidth: (maxWidth ?? minWidth).scale,
          maxHeight: (maxHeight ?? minHeight).scale,
        ),
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
            footer ??
                DialogFooter(
                  type: DialogFooterType.onlyConfirm,
                  onConfirm: () => Navigator.of(context).pop(),
                ),
          ],
        ),
      ),
    );
  }
}
