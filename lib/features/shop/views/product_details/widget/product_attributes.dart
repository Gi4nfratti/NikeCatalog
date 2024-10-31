import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/chips/choice_chip.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/product_price_text.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/product_title_text.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/variation_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MProductAttributes extends StatelessWidget {
  const MProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = MHelperFunctions.isDarkMode(context);

    return Obx(
      () => Column(
        children: [
          if (controller.selectedVariation.value.id.isNotEmpty)
            MRoundedContainer(
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor: dark ? MColors.darkerGrey : MColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const MSectionHeading(
                          title: 'Variação', showActionButton: false),
                      const SizedBox(width: Sizes.spaceBtwItems),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const MProductTitleText(
                                  title: 'Preço: ', smallSize: true),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                    '${controller.selectedVariation.value.price}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(
                                            decoration:
                                                TextDecoration.lineThrough)),
                              const SizedBox(width: Sizes.spaceBtwItems),
                              MProductPriceText(
                                  price: controller.getVariationPrice()),
                            ],
                          ),
                          Row(
                            children: [
                              MProductTitleText(
                                  title: controller.variationStockStatus.value,
                                  smallSize: true),
                              const SizedBox(width: Sizes.spaceBtwItems),
                              Text('Em Estoque',
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  MProductTitleText(
                      title:
                          controller.selectedVariation.value.description ?? '',
                      smallSize: true,
                      maxLines: 4)
                ],
              ),
            ),
          const SizedBox(height: Sizes.spaceBtwItems),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.productAttributes!
                  .map(
                    (attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MSectionHeading(
                            title: attribute.name ?? '',
                            showActionButton: false),
                        SizedBox(height: Sizes.spaceBtwItems / 2),
                        Obx(
                          () => Wrap(
                              spacing: 8,
                              children: attribute.values!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.name] ==
                                    attributeValue;

                                final available = controller
                                    .getAttributesAvailabilityInVariation(
                                        product.productVariations!,
                                        attribute.name!)
                                    .contains(attributeValue);

                                return MChoiceChip(
                                    text: attributeValue,
                                    selected: isSelected,
                                    onSelected: available
                                        ? (selected) {
                                            if (selected && available) {
                                              controller.onAttributeSelected(
                                                  product,
                                                  attribute.name ?? '',
                                                  attributeValue);
                                            }
                                          }
                                        : null);
                              }).toList()),
                        )
                      ],
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
