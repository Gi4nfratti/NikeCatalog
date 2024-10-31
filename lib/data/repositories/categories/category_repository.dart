import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/services/cloud_storage/firebase_storage_service.dart';
import 'package:moraes_nike_catalog/features/shop/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(MFirebaseStorageService());

      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);

        final url =
            await storage.uploadImageData('Categories', file, category.name);

        category.image = url;

        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }
}
