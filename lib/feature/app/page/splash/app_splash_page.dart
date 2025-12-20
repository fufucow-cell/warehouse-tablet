import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/root_router_constant.dart';
import 'package:flutter_smart_home_tablet/feature/app/service/app_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:get/get.dart';

part 'app_splash_page_controller.dart';
part 'app_splash_page_interactive.dart';
part 'app_splash_page_model.dart';
part 'app_splash_page_route.dart';

class AppSplashPage extends GetView<AppSplashPageController> {
  const AppSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppSplashPageController>(
      init: AppSplashPageController(),
      builder: (controller) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
