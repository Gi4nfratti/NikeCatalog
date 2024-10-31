import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/product/product_repository.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/product_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  RxList<ProductModel> products = <ProductModel>[].obs;
  final controller = ProductController.instance;
  final isExpanded = false.obs;
  var searchText = ''.obs;

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah não!', message: e.toString());
      return [];
    }
  }

  void sortProducts(int sortOption) {
    switch (sortOption) {
      case 0: //Nome
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 1: //Maior Preço
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 2: //Menor Preço
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  sortProductsByName(String name) => name.isEmpty
      ? products
      : products.where((product) => product.title.contains(name)).toList();

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts(0);
  }
}
