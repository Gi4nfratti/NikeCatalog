import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/images/circular_image.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MVerticalImageText extends StatelessWidget {
  const MVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = MColors.black,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: Sizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: MCircularImage(
                  image: image,
                  fit: BoxFit.fitWidth,
                  padding: Sizes.sm * 1.4,
                  isNetworkImage: isNetworkImage,
                  backgroundColor: backgroundColor),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2),
            SizedBox(
              width: 70,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
