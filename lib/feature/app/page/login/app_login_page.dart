import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/root_router_constant.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/login/ui/button.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/login/ui/text_field.dart';
import 'package:flutter_smart_home_tablet/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/app/service/app_service.dart';
import 'package:flutter_smart_home_tablet/inherit/base_api_model.dart';
import 'package:flutter_smart_home_tablet/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/util/api_util.dart';
import 'package:flutter_smart_home_tablet/model/request_model/user_login_request_model.dart';
import 'package:flutter_smart_home_tablet/model/response_model/user_login_response_model.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
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
          title: '登入',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer,
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home,
                        size: 80,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 32),
                      const Text('智管家'),
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
