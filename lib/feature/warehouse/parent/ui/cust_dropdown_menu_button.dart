import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_text_widget.dart';

class CustDropdownMenuButton {
  static Widget popupMenuButton({
    String? selectedValue,
    required List<String> values,
    required Function(String?) onValueSelected,
    double? width,
    double? height,
    double? fontSize,
    Color? buttonTextColor,
    double? menuMaxHeight,
    VoidCallback? onMenuOpened,
    bool isShowOnDialog = false,
  }) {
    if (isShowOnDialog) {
      return _TextDropdownButton(
        selectedValue: selectedValue,
        values: values,
        onValueSelected: onValueSelected,
        width: width,
        height: height,
        fontSize: fontSize,
        buttonTextColor: buttonTextColor,
        menuMaxHeight: menuMaxHeight,
        onMenuOpened: onMenuOpened,
      );
    } else {
      final btnWidth = width ?? 280.0.scale;
      final btnHeight = height ?? 70.0.scale;
      return _PopupMenuButtonWidget(
        selectedValue: selectedValue,
        values: values,
        onSelected: onValueSelected,
        width: btnWidth,
        height: btnHeight,
        fontSize: fontSize,
        buttonTextColor: buttonTextColor,
        onOpened: onMenuOpened,
      );
    }
  }
}

class _TextDropdownButton extends StatefulWidget {
  final String? selectedValue;
  final List<String> values;
  final Function(String?) onValueSelected;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? buttonTextColor;
  final double? menuMaxHeight;
  final VoidCallback? onMenuOpened;

  const _TextDropdownButton({
    required this.selectedValue,
    required this.values,
    required this.onValueSelected,
    this.width,
    this.height,
    this.fontSize,
    this.buttonTextColor,
    this.menuMaxHeight,
    this.onMenuOpened,
  });

  @override
  State<_TextDropdownButton> createState() => _TextDropdownButtonState();
}

class _TextDropdownButtonState extends State<_TextDropdownButton> {
  bool _isMenuOpen = false;
  final GlobalKey _buttonKey = GlobalKey();

  void _showMenu(BuildContext context) {
    final textSize = widget.fontSize ?? 32.0.scale;

    final primaryFocus = FocusManager.instance.primaryFocus;
    final hasKeyboard = primaryFocus != null &&
        primaryFocus.context != null &&
        (primaryFocus.context!.widget is TextField || primaryFocus.context!.findAncestorWidgetOfExactType<TextField>() != null);

    widget.onMenuOpened?.call();

    final delayDuration = hasKeyboard ? const Duration(milliseconds: 400) : Duration.zero;

    Future.delayed(delayDuration, () {
      if (!mounted) {
        return;
      }

      final RenderBox? renderBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) {
        return;
      }

      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      final btnWidth = widget.width ?? size.width;
      final menuWidth = btnWidth == double.infinity ? size.width : btnWidth;

      showMenu<String?>(
        context: context,
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + size.height + 10.0.scale,
          offset.dx + size.width,
          offset.dy + size.height + 10.0.scale,
        ),
        constraints: BoxConstraints(
          minWidth: menuWidth,
          maxWidth: menuWidth,
          maxHeight: widget.menuMaxHeight ?? double.infinity,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.0.scale,
            color: EnumColor.lineProduct.color,
          ),
          borderRadius: BorderRadius.circular(16.0.scale),
        ),
        color: EnumColor.backgroundPrimary.color,
        items: widget.values.map((value) {
          final isSelected = widget.selectedValue == value;
          return PopupMenuItem<String?>(
            value: value,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isSelected ? EnumColor.menuBgFocused.color : Colors.transparent,
                borderRadius: BorderRadius.circular(12.0.scale),
              ),
              padding: EdgeInsets.all(16.0.scale),
              child: CustTextWidget(
                value,
                size: textSize,
                color: isSelected ? EnumColor.textPrimary.color : EnumColor.textSecondary.color,
              ),
            ),
          );
        }).toList(),
      ).then((selectedValue) {
        if (mounted) {
          setState(() {
            _isMenuOpen = false;
          });
          if (selectedValue != null) {
            widget.onValueSelected(selectedValue);
          }
        }
      });

      if (mounted) {
        setState(() {
          _isMenuOpen = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final btnHeight = widget.height ?? 70.0.scale;
    final textSize = widget.fontSize ?? 32.0.scale;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final btnWidth = widget.width ?? availableWidth;
        Color btnTextColor;

        if (widget.buttonTextColor != null) {
          btnTextColor = widget.buttonTextColor!;
        } else {
          if (widget.values.isEmpty || widget.selectedValue == null || !widget.values.contains(widget.selectedValue)) {
            btnTextColor = EnumColor.textSecondary.color;
          } else {
            btnTextColor = EnumColor.textPrimary.color;
          }
        }

        return GestureDetector(
          onTap: () {
            if (!_isMenuOpen && widget.values.isNotEmpty) {
              _showMenu(context);
            }
          },
          child: Container(
            key: _buttonKey,
            width: btnWidth,
            height: btnHeight,
            padding: EdgeInsets.symmetric(
              horizontal: 32.0.scale,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: widget.values.isEmpty ? EnumColor.backgroundSecondary.color : EnumColor.backgroundDropdown.color,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.0.scale,
                  color: _isMenuOpen ? EnumColor.lineProduct.color : EnumColor.lineBorder.color,
                ),
                borderRadius: BorderRadius.circular(16.0.scale),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustTextWidget(
                    widget.selectedValue ?? (widget.values.isEmpty ? EnumLocale.optionNoData.tr : EnumLocale.optionPleaseSelect.tr),
                    size: textSize,
                    color: btnTextColor,
                  ),
                ),
                SizedBox(width: 16.0.scale),
                EnumImage.cArrowDown.image(
                  size: Size.square(38.0.scale),
                  color: EnumColor.iconSecondary.color,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PopupMenuButtonWidget extends StatefulWidget {
  final String? selectedValue;
  final List<String> values;
  final Function(String?) onSelected;
  final double width;
  final double height;
  final double? fontSize;
  final Color? buttonTextColor;
  final VoidCallback? onOpened;

  const _PopupMenuButtonWidget({
    required this.selectedValue,
    required this.values,
    required this.onSelected,
    required this.width,
    required this.height,
    this.buttonTextColor,
    this.fontSize,
    this.onOpened,
  });

  @override
  State<_PopupMenuButtonWidget> createState() => _PopupMenuButtonWidgetState();
}

class _PopupMenuButtonWidgetState extends State<_PopupMenuButtonWidget> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final textSize = widget.fontSize ?? 32.0.scale;

    return PopupMenuButton<String?>(
      offset: Offset(0, widget.height + 10.0.scale),
      constraints: BoxConstraints(
        minWidth: widget.width,
        maxWidth: widget.width,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0.scale,
          color: EnumColor.lineProduct.color,
        ),
        borderRadius: BorderRadius.circular(16.0.scale),
      ),
      color: EnumColor.backgroundPrimary.color,
      padding: EdgeInsets.all(16.0.scale),
      onOpened: () {
        setState(() {
          _isMenuOpen = true;
        });
        widget.onOpened?.call();
      },
      onCanceled: () {
        setState(() {
          _isMenuOpen = false;
        });
      },
      onSelected: (value) {
        setState(() {
          _isMenuOpen = false;
        });
        if (value != null) {
          widget.onSelected(value);
        }
      },
      itemBuilder: (context) => widget.values.map((value) {
        final isSelected = widget.selectedValue == value;
        return PopupMenuItem<String?>(
          value: value,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isSelected ? EnumColor.menuBgFocused.color : Colors.transparent,
              borderRadius: BorderRadius.circular(12.0.scale),
            ),
            padding: EdgeInsets.all(16.0.scale),
            child: CustTextWidget(
              value,
              size: textSize,
              color: isSelected ? EnumColor.textPrimary.color : EnumColor.textSecondary.color,
            ),
          ),
        );
      }).toList(),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: EdgeInsets.symmetric(horizontal: 32.0.scale),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: EnumColor.backgroundPrimary.color,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0.scale,
              color: _isMenuOpen ? EnumColor.lineProduct.color : EnumColor.lineBorder.color,
            ),
            borderRadius: BorderRadius.circular(16.0.scale),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustTextWidget(
                widget.selectedValue ?? (widget.values.isEmpty ? EnumLocale.optionNoData.tr : EnumLocale.optionPleaseSelect.tr),
                size: textSize,
                color: widget.buttonTextColor ?? EnumColor.textPrimary.color,
              ),
            ),
            SizedBox(width: 16.0.scale),
            EnumImage.cArrowDown.image(
              size: Size.square(38.0.scale),
              color: EnumColor.iconSecondary.color,
            ),
          ],
        ),
      ),
    );
  }
}

class CustTextDropdownButton extends StatelessWidget {
  const CustTextDropdownButton({
    super.key,
    this.selectedValue,
    required this.values,
    required this.onValueSelected,
    this.width,
    this.height,
    this.fontSize,
    this.buttonTextColor,
    this.menuMaxHeight,
    this.onMenuOpened,
  });

  final String? selectedValue;
  final List<String> values;
  final Function(String?) onValueSelected;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? buttonTextColor;
  final double? menuMaxHeight;
  final VoidCallback? onMenuOpened;

  @override
  Widget build(BuildContext context) {
    // 检测是否在弹窗中
    final isInDialog = context.findAncestorWidgetOfExactType<Dialog>() != null ||
        context.findAncestorWidgetOfExactType<AlertDialog>() != null ||
        context.findAncestorWidgetOfExactType<SimpleDialog>() != null;

    // 在弹窗或页面中，使用 popupMenuButton
    return CustDropdownMenuButton.popupMenuButton(
      selectedValue: selectedValue,
      values: values,
      onValueSelected: onValueSelected,
      width: width,
      height: height,
      fontSize: fontSize,
      buttonTextColor: buttonTextColor,
      menuMaxHeight: menuMaxHeight,
      onMenuOpened: onMenuOpened,
      isShowOnDialog: isInDialog,
    );
  }
}
