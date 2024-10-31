import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/styles/spacing_styles.dart';
import 'package:moraes_nike_catalog/common/widgets/login_signup/form_divider.dart';
import 'package:moraes_nike_catalog/common/widgets/login_signup/social_buttons.dart';
import 'package:moraes_nike_catalog/features/authentication/views/login/widgets/login_form.dart';
import 'package:moraes_nike_catalog/features/authentication/views/login/widgets/login_header.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const MLoginHeader(),
              const MLoginForm(),
              MFormDivider(dividerText: MTexts.orSignInWith.capitalize!),
              const SizedBox(height: Sizes.spaceBtwSections),
              const MSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
