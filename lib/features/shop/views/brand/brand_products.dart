import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/brands/brand_card.dart';
import 'package:moraes_nike_catalog/common/widgets/products/sortable/sortable_products.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/brand_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/brand_model.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: MAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              MBrandCard(
                showBorder: true,
                brand: brand,
              ),
              SizedBox(height: Sizes.spaceBtwSections),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    const loader = MVerticalProductShimmer();

                    final widget = MCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final brandProducts = snapshot.data!;
                    return MSortableProducts(products: brandProducts);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
