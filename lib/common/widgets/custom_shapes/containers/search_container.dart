import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/device/device_utility.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MSearchContainer extends StatelessWidget {
  const MSearchContainer(
      {super.key,
      this.icon = Icons.search_outlined,
      this.showBackground = true,
      this.showBorder = true,
      this.onTap,
      this.padding =
          const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace)});
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    final dark = MHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => Container(
          width: controller.isExpanded.value
              ? MDeviceUtils.getScreenWidth(context) / 1.5
              : 80.0,
          height: 60.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Padding(
            padding: padding,
            child: Obx(() => TextField(
                  controller: TextEditingController(
                      text: controller.searchText.value)
                    ..selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.searchText.value.length),
                    ),
                  onChanged: (value) => controller.sortProductsByName(value),
                  //arrumar pra filtrar com o search
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    suffixIcon: controller.searchText.value.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.grey[600]),
                            onPressed: () => controller.searchText.value = '',
                          )
                        : null,
                    hintText: 'Procurar na Loja',
                    border: showBorder
                        ? OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Sizes.cardRadiusLg),
                          )
                        : null,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
