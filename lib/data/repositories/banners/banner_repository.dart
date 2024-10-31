import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/shop/models/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }
}
