import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/brands/brand_showcase.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/brand_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/category_model.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/features/shop/views/all_products/all_products.dart';
import 'package:moraes_nike_catalog/features/shop/views/store/widgets/category_brands.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';

class MCategoryTab extends StatelessWidget {
  const MCategoryTab({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                FutureBuilder(
                    future: controller.getBrandsForCategory(category.id),
                    builder: (context, snapshot) {
                      const loader = Column(
                        children: [
                          MListTileShimmer(),
                          SizedBox(height: Sizes.spaceBtwItems),
                          MBoxesShimmer(),
                          SizedBox(height: Sizes.spaceBtwItems),
                        ],
                      );

                      final widget =
                          MCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot, loader: loader);
                      if (widget != null) return widget;

                      final brands = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: brands.length,
                        itemBuilder: (_, index) {
                          final brand = brands[index];
                          return FutureBuilder(
                              future: controller.getBrandProducts(
                                  brandId: brand.id, limit: 3),
                              builder: (context, snapshot) {
                                final widget =
                                    MCloudHelperFunctions.checkMultiRecordState(
                                        snapshot: snapshot, loader: loader);
                                if (widget != null) return widget;

                                final products = snapshot.data!;

                                return MBrandShowcase(
                                  images:
                                      products.map((e) => e.thumbnail).toList(),
                                  brand: brand,
                                );
                              });
                        },
                      );
                    })
                /*CategoryBrands(category: category),
                const SizedBox(height: Sizes.spaceBtwItems),
                FutureBuilder(
                    future:
                        controller.getCategoryProducts(categoryId: category.id),
                    builder: (context, snapshot) {
                      final response =
                          MCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: const MVerticalProductShimmer());

                      if (response != null) return response;

                      final products = snapshot.data!;

                      return Column(
                        children: [
                          MSectionHeading(
                              title: 'Você deve gostar',
                              showActionButton: true,
                              onPressed: () => Get.to(AllProductsView(
                                    title: category.name,
                                    futureMethod:
                                        controller.getCategoryProducts(
                                            categoryId: category.id, limit: -1),
                                  ))),
                          const SizedBox(height: Sizes.spaceBtwItems),
                          MGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) => MProductCardVertical(
                                    product: products[index],
                                  )),
                        ],
                      );
                    }),*/
              ],
            ),
          ),
        ]);
  }
}
