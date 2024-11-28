import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/categories/category_repository.dart';
import 'package:moraes_nike_catalog/data/repositories/product/product_repository.dart';
import 'package:moraes_nike_catalog/features/shop/models/category_model.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  bool isClickingAgain = false;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final RxList<bool> isSelectedList = <bool>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
      isSelectedList.value =
          List<bool>.filled(featuredCategories.length, false);
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    final products = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }

  String getCategoryOfProduct(String categoryId) {
    final catName = allCategories.where((cat) => cat.id == categoryId).single;
    return catName.name;
  }

  bool toggleSelectedList({int index = -1}) {
    isClickingAgain =
        isSelectedList.isNotEmpty && index != -1 && isSelectedList[index]
            ? true
            : false;

    isSelectedList.fillRange(0, isSelectedList.length, false);
    if (index != -1 && !isClickingAgain) {
      isSelectedList[index] = !isSelectedList[index];
    }
    isSelectedList.refresh();
    return isClickingAgain;
  }
}
