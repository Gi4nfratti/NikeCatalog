import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/device/device_utility.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Positioned(
      right: Sizes.defaultSpace,
      bottom: MDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? MColors.primary : Colors.black),
        child: const Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }
}
