import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/tabbar.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/brands/brand_card.dart';
import 'package:moraes_nike_catalog/common/widgets/products/sortable/sortable_products.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/brands_shimmer.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/brand_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/features/shop/views/brand/brand_products.dart';
import 'package:moraes_nike_catalog/features/shop/views/store/widgets/category_tab.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/device/device_utility.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final controller = Get.put(AllProductsController());
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
          appBar: MAppBar(
            title: Text(
              'Catálogo Nike',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: [MFavoriteCounterIcon()],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.md),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MSearchContainer(
                        onTap: controller.toggleExpansion,
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: Sizes.sm),
                      IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () => showBottomSheet(
                            context: context,
                            builder: (context) {
                              var options = [
                                "Nome",
                                "Maior Preço",
                                "Menor Preço"
                              ];
                              return ListView.builder(
                                itemCount: options.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return TextButton(
                                    child: Text(
                                      options[index],
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    onPressed: () {
                                      controller.sortProducts(index);
                                      Get.back();
                                    },
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: brandController.getBrandProducts(brandId: "1"),
                      builder: (context, snapshot) {
                        const loader = MVerticalProductShimmer();

                        final widget =
                            MCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot, loader: loader);
                        if (widget != null) return widget;

                        final brandProducts = snapshot.data!;
                        return MSortableProducts(products: brandProducts);
                      }),
                ],
              ),
            ),
          )),
    );
  }
}
