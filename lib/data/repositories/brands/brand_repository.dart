import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/shop/models/brand_model.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
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

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      List<BrandModel> brands =
          brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
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
