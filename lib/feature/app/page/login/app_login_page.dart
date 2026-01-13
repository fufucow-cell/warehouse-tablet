import 'package:engo_terminal_app3/service/api_service/api_service.dart';
import 'package:engo_terminal_app3/service/router_service/router_service_model.dart';
import 'package:engo_terminal_app3/ui/cust_scaffold.dart';
import 'package:engo_terminal_app3/feature/app/page/login/ui/button.dart';
import 'package:engo_terminal_app3/feature/app/page/login/ui/text_field.dart';
import 'package:engo_terminal_app3/feature/app/service/app_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/base_api_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/request_model/user_login_request_model/user_login_request_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/user_login_response_model/user_login_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/theme_service/theme/image_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'app_login_page_controller.dart';
part 'app_login_page_interactive.dart';
part 'app_login_page_model.dart';
part 'app_login_page_route.dart';

class AppLoginPage extends GetView<AppLoginPageController> {
  const AppLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLoginPageController>(
      init: AppLoginPageController(),
      builder: (controller) {
        return CustScaffold(
          title: EnumLocale.loginTitle.tr,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EnumImage.cHouse.image(
                        size: Size.square(150.0.scale),
                        color: Theme.of(context).dividerColor,
                      ),
                      const SizedBox(height: 32),
                      Text(EnumLocale.appTitle.tr),
                      const SizedBox(height: 48),
                      _LoginForms(controller: controller),
                      const _LoginButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginForms extends StatelessWidget {
  final AppLoginPageController controller;

  const _LoginForms({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginUITextField.email(
          textController: controller.emailController,
        ),
        const SizedBox(height: 16),
        const LoginUITextField.password(),
      ],
    );
  }
}

class _LoginButtons extends StatelessWidget {
  const _LoginButtons();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LoginUIButton(
          type: LoginActionButtonType.login,
        ),
        SizedBox(height: 12),
        LoginUIButton(
          type: LoginActionButtonType.register,
        ),
      ],
    );
  }
}
