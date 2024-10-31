import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/product_controller.dart';
import 'package:moraes_nike_catalog/features/shop/views/all_products/all_products.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/widgets/home_appbar.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/widgets/home_categories.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/widgets/promo_slider.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MPrimaryHeaderContainer(
              child: Column(
                children: [
                  MHomeAppBar(),
                  SizedBox(height: Sizes.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: Sizes.defaultSpace),
                    child: Column(
                      children: [
                        MSectionHeading(
                          title: '',
                          showActionButton: false,
                        ),
                        SizedBox(height: Sizes.spaceBtwItems),
                        MHomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  const MPromoSlider(),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  MSectionHeading(
                    title: 'Populares',
                    onPressed: () => Get.to(() => AllProductsView(
                          title: 'Populares',
                          futureMethod: controller.fetchAllFeaturedProducts(),
                        )),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(color: Colors.blue));
                    }

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                          child: Text('Nenhum dado encontrado!',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return MGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => MProductCardVertical(
                            product: controller.featuredProducts[index]));
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
