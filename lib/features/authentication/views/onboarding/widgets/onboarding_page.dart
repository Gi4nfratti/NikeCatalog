import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      child: Column(
        children: [
          Image(
              width: MHelperFunctions.screenWidth() * 0.8,
              height: MHelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Sizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
