import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/data/repositories/user/user_repository.dart';
import 'package:moraes_nike_catalog/features/authentication/views/login/login.dart';
import 'package:moraes_nike_catalog/features/personalization/models/user_model.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');

          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join('') : '',
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      MLoaders.warningSnackBar(
          title: 'Dados não foram salvos',
          message: 'Algo deu errado. Pode salvar seus dados no seu Perfil');
    }
  }

  void deleteAccountWarningPopup() {
    final isDark = MHelperFunctions.isDarkMode(Get.context!);
    Get.defaultDialog(
        backgroundColor: MColors.white,
        contentPadding: const EdgeInsets.all(Sizes.md),
        title: 'Deletar Conta',
        middleText:
            'Você tem certeza que deseja deletar sua conta permanentemente?',
        confirm: ElevatedButton(
            onPressed: () => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.lg),
              child: Text('Deletar'),
            )),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? MColors.black : MColors.white,
                side: BorderSide(color: isDark ? MColors.white : MColors.blue)),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
              child: Text(
                'Cancelar',
                style: TextStyle(color: isDark ? MColors.white : MColors.black),
              ),
            )));
  }

  void deleteUserAccount() async {
    try {
      MFullScreenLoader.openLoadingDialog(
          'Processando...', MImages.deleteAccount);

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          MFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          MFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.warningSnackBar(title: 'Ah não', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      MFullScreenLoader.openLoadingDialog('Processando', MImages.signIn);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      MFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.warningSnackBar(title: 'Ah Não!', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);
        user.value.profilePicture = imageUrl;
        user.refresh();
        MLoaders.successSnackBar(
            title: 'Tudo Certo!',
            message: 'Sua foto de perfil foi atualizada com sucesso');
      }
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não!', message: 'Algo deu errado');
    } finally {
      imageUploading.value = false;
    }
  }
}
