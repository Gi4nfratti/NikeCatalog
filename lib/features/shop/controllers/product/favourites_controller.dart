import 'dart:convert';

import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/product/product_repository.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/local_storage/storage_utility.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  RxInt noOfFavItems = 0.obs;
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  void initFavorites() {
    final json = MLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
      noOfFavItems.value = favorites.length;
    }
  }

  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoriteToStorage();
      MLoaders.customToast(message: 'Adicionado aos Favoritos!');
    } else {
      MLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoriteToStorage();
      favorites.refresh();
      MLoaders.customToast(message: 'Removido dos Favoritos!');
    }
    noOfFavItems.value = favorites.length;
  }

  void saveFavoriteToStorage() {
    final encodedFavorites = json.encode(favorites);
    MLocalStorage.instance().writeData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavouriteProducts(favorites.keys.toList());
  }
}
