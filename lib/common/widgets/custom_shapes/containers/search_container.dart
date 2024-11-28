import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/device/device_utility.dart';

class MSearchContainer extends StatelessWidget {
  const MSearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AllProductsController.instance;
    return Obx(
      () => GestureDetector(
        onTap: () => controller.toggleExpansion(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: controller.isExpanded.value
              ? MDeviceUtils.getScreenWidth(context) / 1.5
              : 60.0,
          height: 60.0,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              Expanded(
                child: AnimatedCrossFade(
                  firstChild: const SizedBox(),
                  secondChild: TextField(
                    controller:
                        TextEditingController(text: controller.searchText.value)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: controller.searchText.value.length),
                          ),
                    onChanged: (value) async {
                      var list =
                          await controller.readProducts(filterByName: value);

                      controller.assignProducts(list);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Procurar na Loja',
                      border: InputBorder.none,
                    ),
                  ),
                  crossFadeState: controller.isExpanded.value
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
