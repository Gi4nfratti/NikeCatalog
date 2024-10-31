import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/device/device_utility.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MTabbar extends StatelessWidget implements PreferredSizeWidget {
  const MTabbar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? MColors.black : MColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: MColors.primary,
        labelColor: dark ? MColors.white : MColors.primary,
        unselectedLabelColor: MColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MDeviceUtils.getAppBarHeight());
}
