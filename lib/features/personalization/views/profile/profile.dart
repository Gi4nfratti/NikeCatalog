import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/images/circular_image.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/user_controller.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/widgets/profile_menu.dart';
import 'package:moraes_nike_catalog/routes/routes.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const MAppBar(
        showBackArrow: true,
        title: Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePicture;
                    final image =
                        networkImage.isNotEmpty ? networkImage : MImages.user;
                    return controller.imageUploading.value
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                CircularProgressIndicator(color: MColors.black))
                        : MCircularImage(
                            image: image,
                            width: 80,
                            height: 80,
                            isNetworkImage: networkImage.isNotEmpty);
                  }),
                  TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Alterar foto de perfil'))
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: Sizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MSectionHeading(
                    title: "Informações do perfil", showActionButton: false),
                IconButton(
                    onPressed: () => Get.offAndToNamed(MRoutes.changeField),
                    icon: Icon(Icons.edit_outlined))
              ],
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            MProfileMenu(title: 'Nome', value: controller.user.value.fullName),
            MProfileMenu(title: 'E-mail', value: controller.user.value.email),
            MProfileMenu(
                title: 'Telefone', value: controller.user.value.phoneNumber),
            Center(
              child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Deletar Conta',
                    style: TextStyle(color: Colors.red),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
