import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/features/shop/views/product_details/widget/product_attributes.dart';
import 'package:moraes_nike_catalog/features/shop/views/product_details/widget/product_detail_image_slider.dart';
import 'package:moraes_nike_catalog/features/shop/views/product_details/widget/product_meta_data.dart';
import 'package:moraes_nike_catalog/utils/constants/enums.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MProductImageSlider(product: product),
            Padding(
              padding: const EdgeInsets.only(
                  right: Sizes.defaultSpace,
                  left: Sizes.defaultSpace,
                  bottom: Sizes.defaultSpace),
              child: Column(
                children: [
                  MProductMetaData(product: product),
                  if (product.productType == ProductType.variable.toString())
                    MProductAttributes(product: product),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  const MSectionHeading(
                      title: 'Descrição', showActionButton: false),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Ver mais',
                    trimExpandedText: 'Ver menos',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
