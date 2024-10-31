import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/data/repositories/user/user_repository.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/verify_email.dart';
import 'package:moraes_nike_catalog/features/personalization/models/user_model.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      MFullScreenLoader.openLoadingDialog(
          'Processando as Informações...', MImages.lProcInfo);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      } else if (!signupFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      } else if (!privacyPolicy.value) {
        MLoaders.warningSnackBar(
            title: 'Política de Privacidade',
            message:
                'Para criar a conta é necessário aceitar os Termos de Política de Privacidade');
        return;
      } else {
        final userCredential = await AuthenticationRepository.instance
            .registerWithEmailAndPassword(
                email.text.trim(), password.text.trim());

        final newUser = UserModel(
            id: userCredential.user!.uid,
            firstName: firstName.text.trim(),
            lastName: lastName.text.trim(),
            email: email.text.trim(),
            phoneNumber: phoneNumber.text.trim(),
            profilePicture: '');

        final userRepository = Get.put(UserRepository());
        await userRepository.saveUserRecord(newUser);

        MFullScreenLoader.stopLoading();
        MLoaders.successSnackBar(
            title: 'Tudo certo!',
            message:
                'Sua conta foi criada. Verifique seu e-mail para continuar');

        Get.to(() => VerifyEmailScreen(email: email.text.trim()));
      }
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ah Não!', message: e.toString());
    }
  }
}
