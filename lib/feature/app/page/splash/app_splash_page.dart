import 'dart:async';

import 'package:engo_terminal_app3/service/router_service/router_service_model.dart';
import 'package:engo_terminal_app3/feature/app/service/app_service.dart';
import 'package:flutter/material.dart';
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
