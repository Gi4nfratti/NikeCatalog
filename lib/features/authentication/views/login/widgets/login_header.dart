import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MLoginHeader extends StatelessWidget {
  const MLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? MImages.darkAppLogo : MImages.lightAppLogo),
        ),
        Text(
          MTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: Sizes.sm),
        Text(
          MTexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
