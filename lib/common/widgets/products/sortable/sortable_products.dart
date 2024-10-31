import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MSortableProducts extends StatelessWidget {
  const MSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => MGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => MProductCardVertical(
                    product: controller.products[index],
                  )),
        ));
  }
}