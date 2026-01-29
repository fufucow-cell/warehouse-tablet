import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/filter/air_quality_filter_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/service/air_quality_service.dart';
import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
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
            child: Stack(
              children: [
                Positioned.fill(
                  top: -50.0.scale,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: EnumImage.cBackgroundWind2.image(
                      size: Size.square(900.0.scale),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const _TopBar(),
                    SizedBox(height: 48.0.scale),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 757.0.scale,
                                top: 175.0.scale,
                              ),
                              child: _CircularProgress(),
                            ),
                          ),
                          Positioned(
                            left: 123.0.scale,
                            top: 467.0.scale,
                            child: _LeftInfoSection(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.0.scale),
                  ],
                ),
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
                '濾網設定',
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
    return GetBuilder<AirQualityFilterPageController>(
      builder: (_) {
        final percent = controller.filterLifePercent;

        return SizedBox(
          width: 830.90.scale,
          height: 830.90.scale,
          child: Stack(
            children: [
              // 外层圆形（背景）
              Positioned(
                left: 2.90.scale,
                top: 830.89.scale,
                child: Transform.rotate(
                  angle: -1.57, // -90度
                  child: Container(
                    width: 828.0.scale,
                    height: 828.0.scale,
                    decoration: ShapeDecoration(
                      color: EnumColor.accentBlue.color,
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
              ),
              // 进度条（使用 CustomPaint）
              Positioned.fill(
                child: CustomPaint(
                  painter: _CircularProgressPainter(
                    percent: percent,
                    color: EnumColor.accentBlue.color,
                  ),
                ),
              ),
              // 内层内容
              Positioned(
                left: 45.45.scale,
                top: 45.45.scale,
                child: Container(
                  width: 740.0.scale,
                  height: 740.0.scale,
                  decoration: BoxDecoration(
                    color: EnumColor.backgroundSecondary.color,
                    shape: BoxShape.circle,
                  ),
                  // TODO: 添加图片或图标
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final int percent;
  final Color color;

  _CircularProgressPainter({
    required this.percent,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 进度条绘制在整个容器的中心
    // 外层圆形尺寸：828x828，容器尺寸：830.90x830.90
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0.scale; // 进度条宽度

    final center = Offset(size.width / 2, size.height / 2);
    final radius = 828.0.scale / 2 - paint.strokeWidth / 2;

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
    return oldDelegate.percent != percent || oldDelegate.color != color;
  }
}

class _LeftInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return GetBuilder<AirQualityFilterPageController>(
      builder: (_) {
        final filterLifePercent = controller.filterLifePercent;

        return SizedBox(
          width: 493.0.scale,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FilterLifeDaysInput(),
              SizedBox(height: 48.0.scale),
              SizedBox(
                width: 493.0.scale,
                child: CustTextWidget(
                  '濾網壽命:$filterLifePercent%',
                  size: 32.0.scale,
                  weightType: EnumFontWeightType.bold,
                  color: EnumColor.textPrimary.color,
                  align: TextAlign.center,
                ),
              ),
              SizedBox(height: 48.0.scale),
              _ResetButton(),
            ],
          ),
        );
      },
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
    return GetBuilder<AirQualityFilterPageController>(
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 123.0.scale, vertical: 16.0.scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0.scale, // 固定宽度，可以根据需要调整
                    child: CustTextField(
                      controller: controller.filterLifeDaysController,
                      textFieldType: EnumTextFieldType.integer,
                      isReadOnly: !controller.isEditing,
                      additionalInputFormatters: [
                        _PositiveIntegerFormatter(),
                      ],
                      fontSize: 32.0.scale,
                    ),
                  ),
                  SizedBox(width: 8.0.scale),
                  CustTextWidget(
                    '天',
                    size: 32.0.scale,
                    weightType: EnumFontWeightType.regular,
                    color: EnumColor.textPrimary.color,
                  ),
                  SizedBox(width: 16.0.scale),
                  _EditButton(),
                  if (controller.isEditing) ...[
                    SizedBox(width: 8.0.scale),
                    _CancelButton(),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return GetBuilder<AirQualityFilterPageController>(
      builder: (_) {
        return GestureDetector(
          onTap: () {
            if (controller.isEditing) {
              controller.interactive(EnumAirQualityFilterPageInteractive.tapConfirmButton);
            } else {
              controller.interactive(EnumAirQualityFilterPageInteractive.tapEditButton);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0.scale, vertical: 12.0.scale),
            decoration: BoxDecoration(
              color: EnumColor.engoBackgroundOrange400.color,
              borderRadius: BorderRadius.circular(8.0.scale),
            ),
            child: CustTextWidget(
              controller.isEditing ? '確認' : '編輯',
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumAirQualityFilterPageInteractive.tapCancelButton);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0.scale, vertical: 12.0.scale),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0.scale,
            color: EnumColor.engoBackgroundOrange400.color,
          ),
          borderRadius: BorderRadius.circular(8.0.scale),
        ),
        child: CustTextWidget(
          '取消',
          size: 32.0.scale,
          weightType: EnumFontWeightType.regular,
          color: EnumColor.engoBackgroundOrange400.color,
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AirQualityFilterPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumAirQualityFilterPageInteractive.tapResetButton);
      },
      child: Container(
        width: 493.0.scale,
        padding: EdgeInsets.symmetric(horizontal: 88.0.scale, vertical: 16.0.scale),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.41,
            colors: [
              Colors.white.withOpacity(0.60),
              const Color(0x00FBBB84),
            ],
          ),
          border: Border.all(
            width: 1.0.scale,
            color: EnumColor.engoBackgroundOrange400.color,
          ),
          borderRadius: BorderRadius.circular(12.0.scale),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 70.0.scale,
              height: 70.0.scale,
              // TODO: 添加重置图标
            ),
            SizedBox(width: 16.0.scale),
            CustTextWidget(
              '濾網更換重置',
              size: 32.0.scale,
              weightType: EnumFontWeightType.regular,
              color: EnumColor.textPrimary.color,
            ),
          ],
        ),
      ),
    );
  }
}
