import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moraes_nike_catalog/data/repositories/brands/brand_repository.dart';
import 'package:moraes_nike_catalog/data/repositories/product/product_repository.dart';
import 'package:moraes_nike_catalog/features/shop/models/brand_model.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;

  final brandRepository = Get.put(BrandRepository());
  final storage = GetStorage();

  @override
  void onInit() {
    getFeaturedBrands();
    getBrandProducts();
    super.onInit();
  }

  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getBrandProducts() async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand();
      storage.write(
          'products', products.map((product) => product.toJson()).toList());
      return products;
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
      return [];
    }
  }
}
