import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/images/circular_image.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/brand_title_text_with_verified_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/product_price_text.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/product_title_text.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/product_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/enums.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/formatters/formatter.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MProductMetaData extends StatelessWidget {
  const MProductMetaData({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final catController = CategoryController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final darkMode = MHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (salePercentage != null && salePercentage != '0')
              MRoundedContainer(
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
            const SizedBox(width: Sizes.spaceBtwItems),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text('${MFormatter.formatCurrency(product.price)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .apply(decoration: TextDecoration.lineThrough)),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(width: Sizes.spaceBtwItems),
            MProductPriceText(
                price: controller.getProductPrice(product), isLarge: true),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        MProductTitleText(title: product.title),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            MCircularImage(
                image: product.brand != null ? product.brand!.image : '',
                width: 32,
                height: 32,
                overlayColor: darkMode ? MColors.white : MColors.black),
            MBrandTitleTextWithVerifiedIcon(
                title: product.categoryId != null
                    ? catController.getCategoryOfProduct(product.categoryId!)
                    : '',
                brandTextSizes: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
