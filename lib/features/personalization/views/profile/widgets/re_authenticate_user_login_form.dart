import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/user_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:moraes_nike_catalog/utils/validators/validation.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Reautenticar Usuário')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: MValidator.validateEmail,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.arrow_right_alt_outlined),
                      labelText: MTexts.email),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                Obx(() => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) =>
                          MValidator.validadeEmptyText('Password', value),
                      decoration: InputDecoration(
                          labelText: MTexts.password,
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: const Icon(Icons.remove_red_eye_outlined))),
                    )),
                const SizedBox(height: Sizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPasswordUser(),
                      child: const Text('Verificar')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
