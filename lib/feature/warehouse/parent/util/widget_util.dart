import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/grid_view_widget.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/text_widget.dart';
import 'package:shimmer/shimmer.dart';

class WidgetUtil {
  static Widget textWidget(
    String text, {
    double? size,
    TextAlign align = TextAlign.start,
    EnumFontWeightType weightType = EnumFontWeightType.regular,
    Color? color,
    int? maxLines,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    return CustTextWidget(
      text,
      size: size,
      align: align,
      weightType: weightType,
      color: color,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static Widget textRequiredWidget(
    String text, {
    double? size,
    TextAlign align = TextAlign.start,
    EnumFontWeightType weightType = EnumFontWeightType.regular,
    Color? color,
    int? maxLines,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    return CustTextRequiredWidget(
      text,
      size: size,
      align: align,
      weightType: weightType,
      color: color,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static TextStyle textStyle({
    double? size,
    EnumFontWeightType weightType = EnumFontWeightType.regular,
    Color? color,
  }) {
    return TextStyle(
      color: color ?? EnumColor.textPrimary.color,
      fontSize: size ?? 32.0.scale,
      fontWeight: weightType.weight,
      height: 1.4,
      letterSpacing: 0,
    );
  }

  static Widget textField({
    required TextEditingController controller,
    double? height,
    EnumTextFieldType textFieldType = EnumTextFieldType.normal,
    String? hintText,
    double? fontSize,
    Color? textColor,
    Color? hintColor,
    TextInputType? keyboardType,
    int? maxLines,
    bool? expands,
    TextAlignVertical? textAlignVertical,
    TextAlign textAlign = TextAlign.start,
    EdgeInsetsGeometry? padding,
    int? maxLength,
    Widget? prefixIcon,
    double? prefixIconSize,
    bool isReadOnly = false,
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 32.0.scale,
          ),
      height: height ?? 70.0.scale,
      decoration: BoxDecoration(
        color: isReadOnly ? EnumColor.backgroundSecondary.color : EnumColor.backgroundDropdown.color,
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.lineBorder.color,
        ),
        borderRadius: BorderRadius.circular(16.0.scale),
      ),
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        keyboardType: keyboardType ?? textFieldType.keyboardType,
        maxLines: maxLines ?? (expands == true ? null : 1),
        expands: expands ?? false,
        textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
        textAlign: textAlign,
        maxLength: maxLength,
        inputFormatters: () {
          final formatters = textFieldType.inputFormatters;

          if (maxLength != null) {
            formatters.add(LengthLimitingTextInputFormatter(maxLength));
          }

          return formatters.isNotEmpty ? formatters : null;
        }(),
        style: TextStyle(
          fontSize: fontSize ?? 32.0.scale,
          color: textColor ?? EnumColor.textPrimary.color,
        ),
        decoration: InputDecoration(
          hintText: hintText ?? EnumLocale.commonInputHint.tr,
          hintStyle: TextStyle(
            fontSize: fontSize ?? 32.0.scale,
            color: hintColor ?? EnumColor.textSecondary.color,
          ),
          prefixIcon: prefixIcon != null
              ? Container(
                  width: prefixIconSize,
                  height: prefixIconSize,
                  margin: EdgeInsets.only(right: 16.0.scale),
                  alignment: Alignment.center,
                  child: prefixIcon,
                )
              : null,
          border: InputBorder.none,
          isDense: true,
          counterText: '', // 隱藏字符計數器
        ),
      ),
    );
  }

  static Widget textDropdownButton({
    String? selectedValue,
    required List<String> values,
    required Function(String?) onValueSelected,
    double? width,
    double? height,
    double? fontSize,
    Color? buttonTextColor,
    double? menuMaxHeight,
    VoidCallback? onMenuOpened,
  }) {
    return _TextDropdownButtonAuto(
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
  }

  static Widget popupMenuButtonInDialog({
    String? selectedValue,
    required List<String> values,
    required Function(String?) onValueSelected,
    double? width,
    double? height,
    double? fontSize,
    Color? buttonTextColor,
    double? menuMaxHeight,
    VoidCallback? onMenuOpened,
  }) {
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
  }

  static Widget popupMenuButtonInPage({
    required String? selectedValue,
    required List<String> values,
    required Function(String?) onSelected,
    required double width,
    required double height,
    double? fontSize,
    Color? buttonTextColor,
    VoidCallback? onOpened,
  }) {
    return _PopupMenuButtonWidget(
      selectedValue: selectedValue,
      values: values,
      onSelected: onSelected,
      width: width,
      height: height,
      fontSize: fontSize,
      buttonTextColor: buttonTextColor,
      onOpened: onOpened,
    );
  }

  static Widget shimmerWidget({double width = double.infinity, double height = double.infinity, Widget? child, Color? highlightColor}) {
    return Shimmer.fromColors(
      baseColor: EnumColor.backgroundLoadingBase.color,
      highlightColor: highlightColor ?? EnumColor.backgroundLoadingHighlight.color,
      child: child ??
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.scale),
              ),
            ),
          ),
    );
  }

  static Widget networkImage({
    required String url,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    final loadingSize = height ?? width ?? double.infinity;
    Widget imageWidget = Image.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          width: loadingSize,
          height: loadingSize,
          child: shimmerWidget(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => emptyImage(
        width: width,
        height: height,
      ),
    );

    return ClipRRect(borderRadius: BorderRadius.circular(20.0.scale), child: imageWidget);
  }

  static Widget customGridView({
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    required int crossAxisCount,
    EdgeInsets? padding,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return CustomGridView(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      crossAxisCount: crossAxisCount,
      padding: padding ?? EdgeInsets.zero,
      crossAxisSpacing: crossAxisSpacing ?? 32.0.scale,
      mainAxisSpacing: mainAxisSpacing ?? 32.0.scale,
      physics: physics ?? const ClampingScrollPhysics(),
      shrinkWrap: shrinkWrap,
    );
  }

  static Widget emptyImage({
    double? width,
    double? height,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      color: EnumColor.backgroundSecondary.color,
      child: Center(
        child: EnumImage.cEmptyPhoto.image(
          size: Size.square(40.0.scale),
          color: EnumColor.iconSecondary.color,
        ),
      ),
    );
  }

  static Widget emptyWidget({double width = double.infinity, double height = double.infinity}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EnumImage.cEmpty.image(size: Size(422.0.scale, 298.0.scale)),
          SizedBox(height: 24.0.scale),
          WidgetUtil.textWidget(
            EnumLocale.commonNoData.tr,
            size: 28.0.scale,
            color: const Color(0xFFBDBDBD),
          ),
        ],
      ),
    );
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

    // 检查是否有键盘显示（通过检查是否有焦点在 TextField 上）
    final primaryFocus = FocusManager.instance.primaryFocus;
    final hasKeyboard = primaryFocus != null &&
        primaryFocus.context != null &&
        (primaryFocus.context!.widget is TextField || primaryFocus.context!.findAncestorWidgetOfExactType<TextField>() != null);

    // 先调用 onMenuOpened（释放键盘）
    widget.onMenuOpened?.call();

    // 根据是否有键盘来设置延迟时间
    // 如果有键盘，延迟等待键盘消失动画完成；如果没有键盘，立即显示
    final delayDuration = hasKeyboard ? const Duration(milliseconds: 400) : Duration.zero;

    Future.delayed(delayDuration, () {
      if (!mounted) {
        return;
      }

      // 重新获取 button 的位置和大小（如果有键盘，键盘消失后位置会变化）
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
              child: WidgetUtil.textWidget(
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
                  child: WidgetUtil.textWidget(
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
            child: WidgetUtil.textWidget(
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
              child: WidgetUtil.textWidget(
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

class _TextDropdownButtonAuto extends StatelessWidget {
  final String? selectedValue;
  final List<String> values;
  final Function(String?) onValueSelected;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? buttonTextColor;
  final double? menuMaxHeight;
  final VoidCallback? onMenuOpened;

  const _TextDropdownButtonAuto({
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
  Widget build(BuildContext context) {
    // 检测是否在弹窗中
    final isInDialog = context.findAncestorWidgetOfExactType<Dialog>() != null ||
        context.findAncestorWidgetOfExactType<AlertDialog>() != null ||
        context.findAncestorWidgetOfExactType<SimpleDialog>() != null;

    if (isInDialog) {
      // 在弹窗中，使用 popupMenuButtonInDialog
      return WidgetUtil.popupMenuButtonInDialog(
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
      // 在页面中，使用 popupMenuButtonInPage
      final btnWidth = width ?? 280.0.scale;
      final btnHeight = height ?? 70.0.scale;
      return WidgetUtil.popupMenuButtonInPage(
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
