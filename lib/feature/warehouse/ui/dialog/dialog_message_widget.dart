import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';

class DialogMessageWidget extends StatelessWidget {
  final bool Function()? onCancel;
  final bool Function() onConfirm;
  final String title;
  final String message;

  const DialogMessageWidget({
    super.key,
    this.onCancel,
    required this.onConfirm,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return DialogFrame(
      width: 720.0.scale,
      minHeight: 385.0.scale,
      header: DialogHeader(title: title),
      footer: DialogFooter(
        type: onCancel != null ? DialogFooterType.cancelAndConfirm : DialogFooterType.onlyConfirm,
        onCancel: () {
          final result = onCancel?.call() ?? false;
          Navigator.of(context).pop(result);
        },
        onConfirm: () {
          final result = onConfirm.call();
          Navigator.of(context).pop(result);
        },
      ),
      child: SizedBox(
        width: double.infinity,
        child: CustTextWidget(
          message,
          size: 28.0.scale,
          color: EnumColor.textPrimary.color,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
