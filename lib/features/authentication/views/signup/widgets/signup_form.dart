import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/authentication/controllers/signup/signup_controller.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/widgets/terms_checkbox.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:moraes_nike_catalog/utils/validators/validation.dart';

class MSignupForm extends StatelessWidget {
  const MSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        MValidator.validadeEmptyText('Primeiro Nome', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: MTexts.firstName,
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                const SizedBox(width: Sizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        MValidator.validadeEmptyText('Último Nome', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: MTexts.lastName,
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields),
            TextFormField(
              controller: controller.email,
              validator: (value) => MValidator.validateEmail(value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: MTexts.email,
                  prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: Sizes.spaceBtwInputFields),
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => MValidator.validatePhoneNumber(value),
              expands: false,
              inputFormatters: [MaskedInputFormatter('(##) #####-####')],
              decoration: const InputDecoration(
                  labelText: MTexts.phoneNo, prefixIcon: Icon(Icons.phone)),
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
            const SizedBox(height: Sizes.spaceBtwSections),
            const MTermsCheckbox(),
            const SizedBox(height: Sizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signup(),
                  child: const Text(MTexts.createAccount)),
            )
          ],
        ));
  }
}
