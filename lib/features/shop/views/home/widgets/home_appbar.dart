import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/products/cart/fav_menu_icon.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/user_controller.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';

class MHomeAppBar extends StatelessWidget {
  const MHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return MAppBar(
      title: Obx(
        () {
          return controller.profileLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: MColors.white))
              : Text("Olá ${controller.user.value.fullName}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: MColors.white));
        },
      ),
      actions: [
        MFavoriteCounterIcon(
          iconColor: MColors.white,
        )
      ],
    );
  }
}
