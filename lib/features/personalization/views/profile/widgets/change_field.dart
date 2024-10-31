import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/features/authentication/views/profile/update_name_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:moraes_nike_catalog/utils/validators/validation.dart';

class ChangeField extends StatelessWidget {
  const ChangeField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: MAppBar(
        showBackArrow: true,
        title: Text(MTexts.profileChangeTitle,
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MTexts.profileChangeSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          MValidator.validadeEmptyText(MTexts.firstName, value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: MTexts.firstName,
                          prefixIcon: Icon(Icons.person_outline)),
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          MValidator.validadeEmptyText(MTexts.lastName, value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: MTexts.lastName,
                          prefixIcon: Icon(Icons.person_outline)),
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.phoneNo,
                      validator: (value) =>
                          MValidator.validatePhoneNumber(value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: MTexts.phoneNo,
                          prefixIcon: Icon(Icons.phone_outlined)),
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),
                  ],
                )),
            const SizedBox(height: Sizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateField(),
                  child: const Text('Salvar')),
            )
          ],
        ),
      ),
    );
  }
}
