import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/app/page/login/app_login_page.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:get/get.dart';

enum LoginTextFieldType {
  email,
  password,
}

class LoginUITextField extends StatelessWidget {
  final LoginTextFieldType type;
  final TextEditingController? textController;
  final AppLoginPageController? pageController;

  const LoginUITextField.email({
    super.key,
    required this.textController,
  })  : type = LoginTextFieldType.email,
        pageController = null;

  const LoginUITextField.password({
    super.key,
  })  : type = LoginTextFieldType.password,
        textController = null,
        pageController = null;

  @override
  Widget build(BuildContext context) {
    if (type == LoginTextFieldType.email) {
      return TextField(
        controller: textController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: EnumLocale.loginEmail.tr,
          prefixIcon: const Icon(Icons.email),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } else {
      return Obx(
        () {
          final controller = Get.find<AppLoginPageController>();
          final isPasswordVisible = controller.isPasswordVisible;
          return TextField(
            controller: controller.passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: EnumLocale.loginPassword.tr,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => controller.interactive(
                  EnumAppLoginPageInteractive.tapPasswordVisibility,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      );
    }
  }
}
