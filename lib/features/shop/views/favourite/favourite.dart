import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/icons/circular_icon.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/loaders/animation_loader.dart';
import 'package:moraes_nike_catalog/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/favourites_controller.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/home.dart';
import 'package:moraes_nike_catalog/navigation_menu.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouritesController.instance;
    return Scaffold(
      appBar: MAppBar(
        title: Text(
          'Favoritos',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          MCircularIcon(
              icon: Icons.add_outlined,
              onPressed: () => Get.to(const HomeScreen()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    const loader = MVerticalProductShimmer(itemCount: 1);
                    final emptyWidget = MAnimationLoaderWidget(
                      text: 'A lista está vazia...',
                      animation: MImages.emptyFavorites,
                      showAction: true,
                      actionText: 'Vamos adicionar alguns...',
                      onActionPressed: () => Get.to(const HomeScreen()),
                    );
                    final widget = MCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget);

                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return MGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => MProductCardVertical(
                              product: products[index],
                            ));
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
