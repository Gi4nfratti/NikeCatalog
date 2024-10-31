import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'PlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'PlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'PlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser.uid)
          .update(json);
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'PlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'PlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'PlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }
}
