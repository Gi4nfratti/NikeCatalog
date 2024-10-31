import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/category_controller.dart';
import 'package:moraes_nike_catalog/features/shop/views/sub_category/sub_categories.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';

class MHomeCategories extends StatelessWidget {
  const MHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

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
              : SizedBox(
                  height: 80,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryController.featuredCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final category =
                          categoryController.featuredCategories[index];
                      return MVerticalImageText(
                        image: category.image,
                        title: category.name,
                        onTap: () =>
                            Get.to(() => SubCategoriesView(category: category)),
                      );
                    },
                  ),
                );
    });
  }
}
