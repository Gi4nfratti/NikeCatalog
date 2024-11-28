import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/styles/shadows.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/images/rounded_image.dart';
import 'package:moraes_nike_catalog/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/product_title_text.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/product_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/features/shop/views/product_details/product_detail.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/formatters/formatter.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MProductCardVertical extends StatelessWidget {
  const MProductCardVertical({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final isDark = MHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [MShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(Sizes.productImageRadius),
            color: isDark ? MColors.darkerGrey : MColors.white),
        child: Column(
          children: [
            MRoundedContainer(
              height: 150,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: isDark ? MColors.dark : MColors.light,
              child: Stack(
                children: [
                  Center(
                    child: MRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  if (salePercentage != null && salePercentage != '0')
                    Positioned(
                      top: 12,
                      child: MRoundedContainer(
                        radius: Sizes.sm,
                        backgroundColor: MColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.sm, vertical: Sizes.sm),
                        child: Text('$salePercentage%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: MColors.black)),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems / 2),
                    MBrandTitleTextWithVerifiedIcon(title: product.brand!.name),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: Sizes.sm),
                          child: Text(
                              product.salePrice > 0
                                  ? MFormatter.formatCurrency(product.salePrice)
                                  : MFormatter.formatCurrency(product.price),
                              style: Theme.of(context).textTheme.labelMedium!))
                    ],
                  ),
                ),
                MFavouriteIcon(productId: product.id)
              ],
            )
          ],
        ),
      ),
    );
  }
}
