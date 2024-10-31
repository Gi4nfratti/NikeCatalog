import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/authentication/controllers/login/login_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MSocialButtons extends StatelessWidget {
  const MSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: MColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: const Image(
                image: AssetImage(MImages.google),
                width: Sizes.iconMd,
                height: Sizes.iconMd,
              )),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: MColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                image: AssetImage(MImages.facebook),
                width: Sizes.iconMd,
                height: Sizes.iconMd,
              )),
        ),
      ],
    );
  }
}
