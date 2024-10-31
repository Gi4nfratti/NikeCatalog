import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/features/authentication/views/password_configuration/reset_password.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      MFullScreenLoader.openLoadingDialog('Processando...', MImages.lProcInfo);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }
      if (!forgetPasswordFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());
      MFullScreenLoader.stopLoading();
      MLoaders.successSnackBar(
          title: 'E-mail enviado',
          message: 'Foi enviado um e-mail para alterar sua senha');
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ah não', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      MFullScreenLoader.openLoadingDialog('Processando...', MImages.lProcInfo);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      MFullScreenLoader.stopLoading();
      MLoaders.successSnackBar(
          title: 'E-mail enviado',
          message: 'Foi enviado um e-mail para alterar sua senha');
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ah não', message: e.toString());
    }
  }
}
