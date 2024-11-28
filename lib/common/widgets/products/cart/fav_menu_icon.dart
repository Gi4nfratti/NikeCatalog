import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/favourites_controller.dart';
import 'package:moraes_nike_catalog/features/shop/views/favourite/favourite.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MFavoriteCounterIcon extends StatelessWidget {
  const MFavoriteCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    final dark = MHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.to(() => const FavouriteScreen()),
            icon: Icon(Icons.favorite_outline, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: counterBgColor ?? (dark ? MColors.white : MColors.black),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Obx(() => Text(
                    controller.noOfFavItems.value.toString(),
                    style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: counterTextColor ??
                            (dark ? MColors.black : MColors.white),
                        fontSizeFactor: 0.8),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
