import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/images/rounded_image.dart';
import 'package:moraes_nike_catalog/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/product_title_text.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/product_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/enums.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MProductCardHorizontal extends StatelessWidget {
  const MProductCardHorizontal({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          color: dark ? MColors.darkerGrey : MColors.softGrey),
      child: Row(
        children: [
          MRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(Sizes.sm),
            backgroundColor: dark ? MColors.dark : MColors.light,
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: MRoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true),
                ),
                if (salePercentage != null && salePercentage != '0')
                  Positioned(
                    top: 12,
                    child: MRoundedContainer(
                      radius: Sizes.sm,
                      backgroundColor: MColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.sm, vertical: Sizes.xs),
                      child: Text('$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: MColors.black)),
                    ),
                  ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: MFavouriteIcon(productId: product.id))
              ],
            ),
          ),
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: Sizes.sm, left: Sizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MProductTitleText(title: product.title, smallSize: true),
                      SizedBox(height: Sizes.spaceBtwItems / 2),
                      MBrandTitleTextWithVerifiedIcon(
                          title: product.brand!.name)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            if (product.productType ==
                                    ProductType.single.toString() &&
                                product.salePrice > 0)
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: Sizes.sm),
                                  child: Text(
                                    product.price.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  )),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: MColors.dark,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Sizes.cardRadiusMd),
                                bottomRight:
                                    Radius.circular(Sizes.productImageRadius))),
                        child: const SizedBox(
                            width: Sizes.iconLg * 1.2,
                            height: Sizes.iconLg * 1.2,
                            child: Center(
                                child: Icon(Icons.add_outlined,
                                    color: MColors.white))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
