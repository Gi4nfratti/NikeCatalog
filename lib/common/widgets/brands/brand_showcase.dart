import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/brands/brand_card.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/shimmer_effect.dart';
import 'package:moraes_nike_catalog/features/shop/models/brand_model.dart';
import 'package:moraes_nike_catalog/features/shop/views/brand/brand_products.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MBrandShowcase extends StatelessWidget {
  const MBrandShowcase({
    super.key,
    required this.images,
    required this.brand,
  });

  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: MRoundedContainer(
        showBorder: true,
        borderColor: MColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(Sizes.md),
        margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
        child: Column(
          children: [
            MBrandCard(
              showBorder: false,
              brand: brand,
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            Row(
              children: images
                  .map((img) => brandTopProductImageWidget(img, context))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

Widget brandTopProductImageWidget(String image, context) {
  return Expanded(
      child: MRoundedContainer(
          height: 100,
          backgroundColor: MHelperFunctions.isDarkMode(context)
              ? MColors.darkerGrey
              : MColors.light,
          margin: const EdgeInsets.only(right: Sizes.sm),
          padding: const EdgeInsets.all(Sizes.md),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, progress) =>
                const MShimmerEffect(width: 100, height: 100),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )));
}
