import 'package:engo_terminal_app3/wh/feature/gateway/page/children/ui/icon_button.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/page/main/water_value_main_page_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterValueMainPage extends GetView<WaterValueMainPageController> {
  final WaterValueMainPageRouterData routerData;
  const WaterValueMainPage({super.key, required this.routerData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaterValueMainPageController>(
      init: WaterValueMainPageController(routerData),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                const _TopBar(),
                SizedBox(height: 72.0.scale),
                const _SwitchControl(),
                SizedBox(height: 128.0.scale),
                const _FunctionCards(),
                SizedBox(height: 72.0.scale),
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
    final controller = Get.find<WaterValueMainPageController>();
    return Row(
      children: [
        CustIconButton(
          icon: EnumImage.cArrowLeft,
          size: 80.0.scale,
          color: EnumColor.engoBackgroundOrange400.color,
          onTap: () {
            controller.interactive(EnumWaterValueMainPageInteractive.tapBackButton);
          },
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CustTextWidget(
                  controller.titleRx.value,
                  size: 40.0.scale,
                  weightType: EnumFontWeightType.bold,
                  color: EnumColor.textPrimary.color,
                ),
              ),
              SizedBox(width: 16.0.scale),
              CustIconButton(
                icon: EnumImage.cPencilLine,
                size: 50.0.scale,
                color: EnumColor.engoTextPrimary.color,
                onTap: () {
                  controller.interactive(EnumWaterValueMainPageInteractive.tapEditButton);
                },
              ),
            ],
          ),
        ),
        CustIconButton(
          icon: EnumImage.cSetting,
          size: 62.0.scale,
          color: EnumColor.engoTextPrimary.color,
          onTap: () {
            controller.interactive(EnumWaterValueMainPageInteractive.tapSettingButton);
          },
        ),
      ],
    );
  }
}

class _SwitchControl extends StatelessWidget {
  const _SwitchControl();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueMainPageController>();
    return Obx(
      () {
        final isOn = controller.isSwitchOnRx.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 水閥图形显示区域
            SizedBox(
              width: 523.0.scale,
              height: 320.0.scale,
              child: Stack(
                children: [
                  // 使用图片资源
                  if (isOn) EnumImage.tWaterValueOn.image(fit: BoxFit.contain) else EnumImage.tWaterValueOff.image(fit: BoxFit.contain),
                ],
              ),
            ),
            SizedBox(height: 48.0.scale),
            // 三个按钮水平排列
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "關閉"按钮
                _AnimatedButton(
                  isSelected: !isOn,
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueMainPageInteractive.tapSwitchToggle,
                      data: false,
                    );
                  },
                  child: Container(
                    width: 200.0.scale,
                    height: 200.0.scale,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0.scale,
                      vertical: 20.0.scale,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3.0.scale,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: EnumColor.engoWaterValueButtonBorder.color,
                        ),
                        borderRadius: BorderRadius.circular(100.0.scale),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustTextWidget(
                          EnumLocale.waterValueClose.tr,
                          size: 32.0.scale,
                          color: EnumColor.textPrimary.color,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 128.0.scale),
                // 中间状态显示
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 144.0.scale,
                      child: CustTextWidget(
                        EnumLocale.waterValueStatus.tr,
                        size: 24.0.scale,
                        color: EnumColor.textPrimary.color,
                        align: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 9.0.scale),
                    CustTextWidget(
                      isOn ? EnumLocale.waterValueOpening.tr : EnumLocale.waterValueClosing.tr,
                      size: 48.0.scale,
                      weightType: EnumFontWeightType.bold,
                      color: isOn ? EnumColor.engoWaterValueStatusOpening.color : EnumColor.engoWaterValueStatusClosing.color,
                      align: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(width: 128.0.scale),
                // "開啟"按钮
                _AnimatedButton(
                  isSelected: isOn,
                  onTap: () {
                    controller.interactive(
                      EnumWaterValueMainPageInteractive.tapSwitchToggle,
                      data: true,
                    );
                  },
                  child: Container(
                    width: 200.0.scale,
                    height: 200.0.scale,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0.scale,
                      vertical: 20.0.scale,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3.0.scale,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: EnumColor.engoWaterValueButtonBorder.color,
                        ),
                        borderRadius: BorderRadius.circular(100.0.scale),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustTextWidget(
                          EnumLocale.waterValueOpen.tr,
                          size: 32.0.scale,
                          color: EnumColor.textPrimary.color,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  const _AnimatedButton({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _FunctionCards extends StatelessWidget {
  const _FunctionCards();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WaterValueMainPageController>();
    return GestureDetector(
      onTap: () {
        controller.interactive(EnumWaterValueMainPageInteractive.tapTimerButton);
      },
      child: Container(
        width: 400.0.scale,
        padding: EdgeInsets.symmetric(
          horizontal: 88.0.scale,
          vertical: 16.0.scale,
        ),
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: EnumColor.engoWaterValueFunctionCardGradient.colors,
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: EnumColor.engoWaterValueFunctionCardBorder.color,
            ),
            borderRadius: BorderRadius.circular(12.0.scale),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EnumImage.cClock.image(
              size: Size.square(70.0.scale),
              color: EnumColor.textPrimary.color,
            ),
            SizedBox(width: 16.0.scale),
            CustTextWidget(
              EnumLocale.waterValueTimer.tr,
              size: 32.0.scale,
              color: EnumColor.textPrimary.color,
            ),
          ],
        ),
      ),
    );
  }
}
