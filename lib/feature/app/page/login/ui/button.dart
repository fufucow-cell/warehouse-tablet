import 'package:engo_terminal_app3/feature/app/page/login/app_login_page.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginActionButtonType {
  login,
  register,
}

class LoginUIButton extends StatelessWidget {
  final LoginActionButtonType type;

  const LoginUIButton({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final controller = Get.find<AppLoginPageController>();
        final isDisabled = controller.isLoading || !controller.isButtonEnabled;
        final onPressed = isDisabled
            ? null
            : () => controller.interactive(
                  type == LoginActionButtonType.login ? EnumAppLoginPageInteractive.tapLogin : EnumAppLoginPageInteractive.tapRegister,
                );

        if (type == LoginActionButtonType.login) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: controller.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      EnumLocale.loginButton.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          );
        } else {
          return SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                EnumLocale.registerButton.tr,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
