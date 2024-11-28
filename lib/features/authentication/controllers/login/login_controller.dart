import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/user_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      MFullScreenLoader.openLoadingDialog('Entrando...', MImages.signIn);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      MFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ah não', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      MFullScreenLoader.openLoadingDialog('Entrando...', MImages.signIn);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredentials);
      MFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ah não!', message: e.toString());
    }
  }
}
