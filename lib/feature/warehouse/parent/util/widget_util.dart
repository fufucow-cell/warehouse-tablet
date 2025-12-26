import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/image_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
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
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle(
        size: size,
        weightType: weightType,
        color: color ?? EnumColor.textPrimary.color,
      ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '*',
          style: textStyle(
            size: size,
            weightType: weightType,
            color: EnumColor.accentRed.color,
          ),
        ),
        Text(
          text,
          textAlign: align,
          maxLines: maxLines,
          overflow: overflow,
          style: textStyle(
            size: size,
            weightType: weightType,
            color: color ?? EnumColor.textPrimary.color,
          ),
        ),
      ],
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
  }) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: 32.0.scale,
          ),
      height: height ?? 70.0.scale,
      decoration: BoxDecoration(
        color: EnumColor.backgroundSecondary.color,
        border: Border.all(
          width: 1.0.scale,
          color: EnumColor.lineBorder.color,
        ),
        borderRadius: BorderRadius.circular(16.0.scale),
      ),
      child: TextField(
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
          hintText: hintText ?? '請輸入',
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
    required Function(String?, int?) onValueSelected,
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

  static Widget shimmerWidget({required Widget child, Color? highlightColor}) {
    return Shimmer.fromColors(
      baseColor: EnumColor.backgroundLoadingBase.color,
      highlightColor: highlightColor ?? EnumColor.backgroundLoadingHighlight.color,
      child: child,
    );
  }

  static Widget emptyImage({double? width = double.infinity, double? height = double.infinity}) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported),
    );
  }

  static Widget networkImage({required String url, double? width, double? height, BoxFit? fit}) {
    final loadingSize = height ?? width ?? double.infinity;
    Widget imageWidget = Image.network(
      url,
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
        width: width ?? loadingSize,
        height: height ?? loadingSize,
      ),
    );

    // 如果只设置了 height，使用 ConstrainedBox 限制高度，宽度自适应
    if (height != null && width == null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height,
          minHeight: height,
        ),
        child: imageWidget,
      );
    } else if (width != null && height == null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
          minWidth: width,
        ),
        child: imageWidget,
      );
    } else {
      return SizedBox(
        width: width,
        height: height,
        child: imageWidget,
      );
    }
  }
}

class _TextDropdownButton extends StatefulWidget {
  final String? selectedValue;
  final List<String> values;
  final Function(String?, int?) onValueSelected;
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
      if (renderBox == null) return;

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
            widget.onValueSelected(selectedValue, widget.values.indexOf(selectedValue));
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
              color: widget.values.isEmpty ? EnumColor.backgroundSecondary.color : EnumColor.backgroundPrimary.color,
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
                    widget.selectedValue ?? (widget.values.isEmpty ? '無資料' : '請選擇'),
                    size: textSize,
                    color: widget.buttonTextColor ?? EnumColor.textPrimary.color,
                  ),
                ),
                SizedBox(width: 16.0.scale),
                EnumImage.cArrowDown.image(
                  size: Size.square(38.0.scale),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
