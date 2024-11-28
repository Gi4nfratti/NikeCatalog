import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/images/circular_image.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:moraes_nike_catalog/features/shop/models/brand_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/enums.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MBrandCard extends StatelessWidget {
  const MBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });

  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MRoundedContainer(
        padding: const EdgeInsets.all(Sizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: MCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: MHelperFunctions.isDarkMode(context)
                    ? MColors.white
                    : MColors.black,
              ),
            ),
            const SizedBox(width: Sizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MBrandTitleTextWithVerifiedIcon(
                    title: brand.name,
                    brandTextSizes: TextSizes.large,
                  ),
                  Text(
                    '${brand.productsCount ?? 0} produtos',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: MColors.darkGrey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
