import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:moraes_nike_catalog/common/widgets/products/cart/fav_menu_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/products/sortable/sortable_products.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/widgets/home_categories.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final categories = categoryController.featuredCategories;
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
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo/nike_wallpaper.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.md),
                child: Column(
                  children: [
                    MHomeCategories(),
                    SizedBox(height: Sizes.spaceBtwSections),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Sizes.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MSearchContainer(),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
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
                    ),
                    FutureBuilder(
                        future: controller.readProducts(),
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
            ),
          )),
    );
  }
}
