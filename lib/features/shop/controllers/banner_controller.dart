import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/banners/banner_repository.dart';
import 'package:moraes_nike_catalog/features/shop/models/banner_model.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class BannerController extends GetxController {
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();
      this.banners.assignAll(banners);
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
