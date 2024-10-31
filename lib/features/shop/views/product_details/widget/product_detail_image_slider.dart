import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:moraes_nike_catalog/common/widgets/images/rounded_image.dart';
import 'package:moraes_nike_catalog/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/images_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MProductImageSlider extends StatelessWidget {
  const MProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDark = MHelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);
    return MCurvedEdgeWidget(
      child: Container(
        color: isDark ? MColors.darkGrey : MColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: EdgeInsets.all(Sizes.productImageRadius * 2),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: MColors.primary,
                              )),
                    );
                  })),
                )),
            Positioned(
              right: 0,
              bottom: 30,
              left: Sizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: Sizes.spaceBtwItems),
                  itemCount: images.length,
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return MRoundedImage(
                      isNetworkImage: true,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      backgroundColor: isDark ? MColors.dark : MColors.white,
                      imageUrl: images[index],
                      width: 80,
                      border: Border.all(
                          color: imageSelected
                              ? MColors.primary
                              : Colors.transparent),
                      padding: const EdgeInsets.all(Sizes.sm),
                    );
                  }),
                ),
              ),
            ),
            MAppBar(
              showBackArrow: true,
              actions: [MFavouriteIcon(productId: product.id)],
            )
          ],
        ),
      ),
    );
  }
}
