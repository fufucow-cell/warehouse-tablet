import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_field.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/air_background_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AirQualityFilterPage extends GetView<AirQualityFilterPageController> {
  final AirQualityFilterPageRouterData routerData;
  const AirQualityFilterPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirQualityFilterPageController>(
      init: AirQualityFilterPageController(routerData),
      builder: (controller) {
        AirQualityService.register().setContext(context);
        return Scaffold(
          body: AirBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _LeftInfoSection()),
                      Expanded(child: _CircularProgress()),
                    ],
                  ),
                ),
                SizedBox(height: 32.0.scale),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumAirQualityFilterPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustTextWidget(
                EnumLocale.purifierFilterSettings.tr,
                size: 40.0.scale,
                weightType: EnumFontWeightType.bold,
                color: EnumColor.textPrimary.color,
              ),
            ],
          ),
        ),
        SizedBox(width: 80.0.scale), // 占位，保持居中
      ],
    );
  }
}

class _CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    // Expanded 會壓縮子組件，用 FittedBox 讓內部固定 700*700 再縮放適應，painter 才能拿到 700*700
    return Obx(
      () {
        controller.isResetRx.value;
        return FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 700.0.scale,
            height: 700.0.scale,
            child: Stack(
              children: [
                // 圓形背景
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: EnumColor.progressTrack.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // 圓圈進度條（中間層）
                Positioned.fill(
                  child: CustomPaint(
                    painter: _CircularProgressPainter(
                      percent: controller.filterLifePercent,
                    ),
                  ),
                ),
                // 圓形上的圖片（內縮，最上層）
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(30.0.scale),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(EnumImage.cAirFilter.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final int percent;

  _CircularProgressPainter({
    required this.percent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 30.0.scale;
    final paint = Paint()
      ..color = EnumColor.accentBlue.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 350.0.scale - strokeWidth / 2;

    // 绘制进度条（从顶部开始，顺时针）
    final progressAngle = (percent / 100) * 2 * 3.14159;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(
      rect,
      -1.57, // 从顶部开始（-90度）
      progressAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}

class _LeftInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () {
            controller.isResetRx.value;
            return CustTextWidget(
              '${EnumLocale.purifierFilterLife.tr}:${controller.filterLifePercent}%',
              size: 32.0.scale,
              weightType: EnumFontWeightType.bold,
              color: EnumColor.textPrimary.color,
              align: TextAlign.center,
            );
          },
        ),
        SizedBox(height: 48.0.scale),
        _ResetButton(),
        SizedBox(height: 48.0.scale),
        _FilterLifeDaysInput(),
      ],
    );
  }
}

/// 限制输入大于0的整数
class _PositiveIntegerFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 如果输入为空，允许（但实际使用时应该至少为1）
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // 只允许数字
    if (!RegExp(r'^\d+$').hasMatch(newValue.text)) {
      return oldValue;
    }

    // 解析为整数
    final intValue = int.tryParse(newValue.text);
    if (intValue == null) {
      return oldValue;
    }

    // 必须大于0
    if (intValue <= 0) {
      return oldValue;
    }

    return newValue;
  }
}

class _FilterLifeDaysInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return Obx(
      () {
        final isEditing = controller.isEditingRx.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150.0.scale,
              child: CustTextField(
                controller: controller.textController,
                height: 90.0.scale,
                textAlign: TextAlign.center,
                textFieldType: EnumTextFieldType.integer,
                isReadOnly: !isEditing,
                additionalInputFormatters: [
                  _PositiveIntegerFormatter(),
                ],
                fontSize: 32.0.scale,
              ),
            ),
            SizedBox(width: 8.0.scale),
            CustTextWidget(
              EnumLocale.engoTabDay.tr,
              size: 32.0.scale,
            ),
            SizedBox(width: 32.0.scale),
            _EditButton(),
            if (isEditing) ...[
              SizedBox(width: 8.0.scale),
              _CancelButton(),
            ],
          ],
        );
      },
    );
  }
}

class _EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    final borderRadius = BorderRadius.circular(8.0.scale);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: EnumColor.engoBackgroundOrange400.color,
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: () {
            if (controller.isEditingRx.value) {
              controller.interactive(EnumAirQualityFilterPageInteractive.tapConfirmButton);
            } else {
              controller.interactive(EnumAirQualityFilterPageInteractive.tapEditButton);
            }
          },
          borderRadius: borderRadius,
          child: Container(
            alignment: Alignment.center,
            height: 90.0.scale,
            padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
            child: CustTextWidget(
              controller.isEditingRx.value ? EnumLocale.commonConfirm.tr : EnumLocale.warehouseItemEdit.tr,
              size: 32.0.scale,
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    final borderRadius = BorderRadius.circular(8.0.scale);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0.scale,
            color: EnumColor.engoBackgroundOrange400.color,
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: () {
            controller.interactive(EnumAirQualityFilterPageInteractive.tapCancelButton);
          },
          borderRadius: borderRadius,
          child: Container(
            alignment: Alignment.center,
            height: 90.0.scale,
            padding: EdgeInsets.symmetric(horizontal: 24.0.scale),
            child: CustTextWidget(
              EnumLocale.commonCancel.tr,
              size: 32.0.scale,
              color: EnumColor.engoBackgroundOrange400.color,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    final borderRadius = BorderRadius.circular(12.0.scale);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: EnumColor.backgroundItemGradient.colors,
          ),
          border: Border.all(
            width: 1.0.scale,
            color: EnumColor.engoBackgroundOrange400.color,
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: () {
            controller.interactive(EnumAirQualityFilterPageInteractive.tapResetButton);
          },
          borderRadius: borderRadius,
          child: Container(
            width: 493.0.scale,
            padding: EdgeInsets.symmetric(horizontal: 88.0.scale, vertical: 16.0.scale),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EnumImage.cReset.image(
                  size: Size.square(70.0.scale),
                  color: EnumColor.engoTextPrimary.color,
                ),
                SizedBox(width: 16.0.scale),
                CustTextWidget(
                  EnumLocale.purifierFilterReset.tr,
                  size: 32.0.scale,
                  color: EnumColor.engoTextPrimary.color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
