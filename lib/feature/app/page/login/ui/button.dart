import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/login/app_login_page.dart';
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
        final isDisabled =
            controller.isLoading || !controller.isButtonEnabled;
        final onPressed = isDisabled
            ? null
            : () => controller.interactive(
                  type == LoginActionButtonType.login
                      ? EnumAppLoginPageInteractive.tapLogin
                      : EnumAppLoginPageInteractive.tapRegister,
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
                      child:
                          CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      '登入',
                      style: TextStyle(fontSize: 16),
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
              child: const Text(
                '註冊',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }
}
