import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/user_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/brand_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/product_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/variation_controller.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(ProductController());
    Get.put(BrandController());
    Get.put(UserController());
  }
}
