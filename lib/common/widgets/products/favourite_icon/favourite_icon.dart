import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/icons/circular_icon.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/favourites_controller.dart';

class MFavouriteIcon extends StatelessWidget {
  const MFavouriteIcon({super.key, required this.productId});

  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => MCircularIcon(
          icon: controller.isFavorite(productId)
              ? Icons.favorite_outlined
              : Icons.favorite_border_outlined,
          color: controller.isFavorite(productId) ? Colors.red : null,
          onPressed: () => controller.toggleFavoriteProduct(productId),
        ));
  }
}
