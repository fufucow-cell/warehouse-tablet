import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';

enum DialogFooterType {
  onlyConfirm,
  cancelAndConfirm,
  deleteWithBoth,
}

class DialogFooter extends StatelessWidget {
  final DialogFooterType type;
  final bool isLoading;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  const DialogFooter({
    super.key,
    required this.type,
    this.isLoading = false,
    this.onConfirm,
    this.onCancel,
    this.onDelete,
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
      child: _buildFooterContent(context),
    );
  }

  Widget _buildFooterContent(BuildContext context) {
    switch (type) {
      case DialogFooterType.onlyConfirm:
        return _OnlyConfirmFooter(
          onConfirm: onConfirm,
          isLoading: isLoading,
        );
      case DialogFooterType.cancelAndConfirm:
        return _CancelAndConfirmFooter(
          onCancel: onCancel ?? () => Navigator.of(context).pop(),
          onConfirm: onConfirm,
          isLoading: isLoading,
        );
      case DialogFooterType.deleteWithBoth:
        return _DeleteWithBothFooter(
          onDelete: onDelete,
          onCancel: onCancel ?? () => Navigator.of(context).pop(),
          onConfirm: onConfirm,
          isLoading: isLoading,
        );
    }
  }
}

class _OnlyConfirmFooter extends StatelessWidget {
  final VoidCallback? onConfirm;
  final bool isLoading;

  const _OnlyConfirmFooter({
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _ConfirmButton(
          onPressed: onConfirm,
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _CancelAndConfirmFooter extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool isLoading;

  const _CancelAndConfirmFooter({
    required this.onCancel,
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _CancelButton(
          onPressed: onCancel,
        ),
        SizedBox(width: 16.0.scale),
        _ConfirmButton(
          onPressed: onConfirm,
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _DeleteWithBothFooter extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final bool isLoading;

  const _DeleteWithBothFooter({
    required this.onDelete,
    required this.onCancel,
    required this.onConfirm,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _DeleteButton(
          onPressed: onDelete,
          isLoading: isLoading,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _CancelButton(
              onPressed: onCancel,
            ),
            SizedBox(width: 16.0.scale),
            _ConfirmButton(
              onPressed: onConfirm,
              isLoading: isLoading,
            ),
          ],
        ),
      ],
    );
  }
}

class _BaseFooterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final BorderSide? side;

  const _BaseFooterButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0.scale,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 24.0.scale,
          ),
          backgroundColor: backgroundColor ?? EnumColor.backgroundPrimary.color,
          side: side,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _CancelButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseFooterButton(
      onPressed: onPressed,
      side: BorderSide(
        width: 2.0.scale,
        color: EnumColor.lineBorder.color,
      ),
      child: WidgetUtil.textWidget(
        EnumLocale.commonCancel.tr,
        size: 26.0.scale,
      ),
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _ConfirmButton({
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return _BaseFooterButton(
      onPressed: onPressed,
      backgroundColor: EnumColor.backgroundButton.color,
      child: isLoading
          ? WidgetUtil.shimmerWidget(
              highlightColor: EnumColor.textPrimary.color,
              child: WidgetUtil.textWidget(
                EnumLocale.commonProcessing.tr,
                size: 26.0.scale,
              ),
            )
          : WidgetUtil.textWidget(
              EnumLocale.commonConfirm.tr,
              size: 26.0.scale,
            ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _DeleteButton({
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || onPressed == null;
    return _BaseFooterButton(
      onPressed: isDisabled ? null : onPressed,
      side: BorderSide(
        width: 2.0.scale,
        color: isDisabled ? EnumColor.lineBorder.color : EnumColor.accentRed.color,
      ),
      child: WidgetUtil.textWidget(
        EnumLocale.warehouseOperateTypeDelete.tr,
        size: 26.0.scale,
        color: isDisabled ? EnumColor.textSecondary.color : EnumColor.accentRed.color,
      ),
    );
  }
}
