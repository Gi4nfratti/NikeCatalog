import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/brand_title_text.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/enums.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MBrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const MBrandTitleTextWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = MColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: MBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSizes,
        )),
        const SizedBox(width: Sizes.xs),
        const Icon(Icons.verified_rounded,
            color: MColors.primary, size: Sizes.iconXs)
      ],
    );
  }
}
