import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

enum DialogFooterType {
  onlyConfirm,
  cancelAndConfirm,
}

class DialogFooter extends StatelessWidget {
  final DialogFooterType type;
  final bool isLoading;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const DialogFooter({
    super.key,
    required this.type,
    this.isLoading = false,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 56.0.scale,
        vertical: 24.0.scale,
      ),
      decoration: BoxDecoration(
        color: EnumColor.backgroundPrimary.color,
        border: Border(
          top: BorderSide(
            width: 2.0.scale,
            color: EnumColor.lineDividerLight.color,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (type == DialogFooterType.cancelAndConfirm) ...[
            _button(false, onCancel ?? () => Navigator.of(context).pop()),
            SizedBox(width: 16.0.scale),
          ],
          _button(true, onConfirm),
        ],
      ),
    );
  }

  Widget _button(bool isConfirm, VoidCallback? onPressed) {
    return SizedBox(
      width: 180.0.scale,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 24.0.scale,
          ),
          backgroundColor: isConfirm
              ? EnumColor.backgroundButton.color
              : EnumColor.backgroundPrimary.color,
          side: isConfirm
              ? null
              : BorderSide(
                  width: 2.0.scale,
                  color: EnumColor.lineBorder.color,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
        ),
        child: (isConfirm && isLoading)
            ? WidgetUtil.shimmerWidget(
                highlightColor: EnumColor.textPrimary.color,
                child: WidgetUtil.textWidget(
                  EnumLocale.commonProcessing.tr,
                  size: 26.0.scale,
                ),
              )
            : WidgetUtil.textWidget(
                isConfirm
                    ? EnumLocale.commonConfirm.tr
                    : EnumLocale.commonCancel.tr,
                size: 26.0.scale,
              ),
      ),
    );
  }
}
