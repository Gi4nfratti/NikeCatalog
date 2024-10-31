import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/authentication/controllers/signup/signup_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MTermsCheckbox extends StatelessWidget {
  const MTermsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = MHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
        const SizedBox(width: Sizes.spaceBtwItems),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: '${MTexts.iAgreeTo} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: '${MTexts.privacyPolicy}\n',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? MColors.white : MColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? MColors.white : MColors.primary,
                  )),
          TextSpan(
              text: '${MTexts.and} ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: MTexts.termsOfUse,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? MColors.white : MColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark ? MColors.white : MColors.primary,
                  )),
        ]))
      ],
    );
  }
}
