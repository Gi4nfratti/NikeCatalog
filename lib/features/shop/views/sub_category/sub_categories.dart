import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/images/rounded_image.dart';
import 'package:moraes_nike_catalog/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/category_model.dart';
import 'package:moraes_nike_catalog/features/shop/views/all_products/all_products.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';

class SubCategoriesView extends StatelessWidget {
  const SubCategoriesView({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: MAppBar(title: Text(category.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              MRoundedImage(
                  imageUrl: MImages.promoBanner2,
                  width: double.infinity,
                  applyImageRadius: true),
              const SizedBox(height: Sizes.spaceBtwSections),
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                CircularProgressIndicator())); // MHorizontalProductShimmer();
                    final widget = MCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final subCategories = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subCategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];
                        return FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              final widget =
                                  MCloudHelperFunctions.checkMultiRecordState(
                                      snapshot: snapshot, loader: loader);
                              if (widget != null) return widget;

                              final products = snapshot.data!;

                              return Column(
                                children: [
                                  MSectionHeading(
                                    title: subCategory.name,
                                    onPressed: () =>
                                        Get.to(() => AllProductsView(
                                              title: subCategory.name,
                                              futureMethod: controller
                                                  .getCategoryProducts(
                                                      categoryId:
                                                          subCategory.id,
                                                      limit: -1),
                                            )),
                                  ),
                                  const SizedBox(
                                      height: Sizes.spaceBtwItems / 2),
                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                              width: Sizes.spaceBtwItems),
                                      itemCount: products.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) =>
                                          MProductCardHorizontal(
                                              product: products[index]),
                                    ),
                                  ),
                                  const SizedBox(height: Sizes.spaceBtwSections)
                                ],
                              );
                            });
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
