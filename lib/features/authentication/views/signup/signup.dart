import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/login_signup/form_divider.dart';
import 'package:moraes_nike_catalog/common/widgets/login_signup/social_buttons.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/widgets/signup_form.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: Sizes.spaceBtwSections),
              const MSignupForm(),
              const SizedBox(height: Sizes.spaceBtwSections),
              MFormDivider(dividerText: MTexts.orSignUpWith.capitalize!),
              const SizedBox(height: Sizes.spaceBtwSections),
              const MSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
