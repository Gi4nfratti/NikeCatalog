import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/data/repositories/user/user_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/user_controller.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/profile.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/helpers/networkmanager.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

enum FieldTypes {
  name, //1
  email, //2
  phone, //3
  birthdate, //4
}

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNo = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
    phoneNo.text = userController.user.value.phoneNumber;
  }

  Future<void> updateField() async {
    try {
      MFullScreenLoader.openLoadingDialog(
          'Atualizando suas informações...', MImages.signIn);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      if (!updateUserNameFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      Map<String, dynamic> fields = {};

      if (userController.user.value.firstName != firstName.text)
        fields['FirstName'] = firstName.text.trim();

      if (userController.user.value.lastName != lastName.text)
        fields['LastName'] = lastName.text.trim();

      if (userController.user.value.phoneNumber != phoneNo.text)
        fields['PhoneNumber'] = phoneNo.text.trim();

      if (fields.isNotEmpty) {
        await userRepository.updateSingleField(fields);

        userController.user.value.firstName = firstName.text;
        userController.user.value.lastName = lastName.text;
        userController.user.value.phoneNumber = phoneNo.text;
      }

      MFullScreenLoader.stopLoading();
      MLoaders.successSnackBar(
          title: 'Tudo certo!',
          message: 'Os dados foram atualizados com sucesso');

      Get.offAll(() => const ProfileScreen());
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ah não!', message: e.toString());
    }
  }
}
