import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/authentication/controllers/login/login_controller.dart';
import 'package:moraes_nike_catalog/features/authentication/views/password_configuration/forget_password.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/signup.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:moraes_nike_catalog/utils/validators/validation.dart';

class MLoginForm extends StatelessWidget {
  const MLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => MValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.turn_right_outlined),
                  labelText: MTexts.email),
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => MValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                    labelText: MTexts.password,
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(controller.hidePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility),
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                    )),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    const Text(MTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => (Get.to(() => const ForgetPasswordScreen())),
                  child: const Text(MTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordSignIn(),
                    child: const Text(MTexts.signIn))),
            const SizedBox(height: Sizes.spaceBtwItems),
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignupScreen()),
                    child: const Text(MTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
