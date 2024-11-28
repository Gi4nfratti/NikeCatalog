import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/brand_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MHomeCategories extends StatelessWidget {
  const MHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final brandController = BrandController.instance;
    final allProductsController = AllProductsController.instance;
    categoryController.toggleSelectedList();

    return Obx(() {
      return categoryController.featuredCategories.isEmpty
          ? Center(
              child: Text('Nenhum dado encontrado!',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: MColors.white)),
            )
          : categoryController.isLoading.value
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(color: Colors.lightBlue))
              : Card(
                  color: MColors.light,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.md, vertical: Sizes.sm / 2),
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoryController.featuredCategories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final category =
                              categoryController.featuredCategories[index];
                          return Obx(
                            () => MVerticalImageText(
                                image: category.image,
                                title: category.name,
                                onTap: () async {
                                  bool clickAgain = categoryController
                                      .toggleSelectedList(index: index);
                                  var list =
                                      await allProductsController.readProducts(
                                          filterCategoryId:
                                              clickAgain ? "0" : category.id);

                                  allProductsController.assignProducts(list);
                                },
                                backgroundColor:
                                    categoryController.isSelectedList[index]
                                        ? MColors.softGrey
                                        : MColors.light),
                          );
                        },
                      ),
                    ),
                  ),
                );
    });
  }
}
