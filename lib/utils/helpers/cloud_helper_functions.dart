import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';

class MCloudHelperFunctions {
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    const loader = SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(color: MColors.black));
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader;
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(
        child: Text('Sem dados para exibir'),
      );
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Algo deu errado'));
    }

    return null;
  }

  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (loader == null) {
      const loader = SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(color: MColors.black));
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return loader;
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return nothingFound ??
          const Center(
            child: Text('Sem dados para exibir'),
          );
    }

    if (snapshot.hasError) {
      return error ?? const Center(child: Text('Algo deu errado'));
    }
    return null;
  }

  static Future<String> getURLFromFilePathAndName(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'Algo deu errado';
    }
  }
}
