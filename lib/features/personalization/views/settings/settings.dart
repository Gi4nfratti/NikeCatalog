import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:moraes_nike_catalog/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:moraes_nike_catalog/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/profile.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/constants/text_strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MPrimaryHeaderContainer(
                child: Column(
              children: [
                MAppBar(
                  title: Text(
                    MTexts.myAccount,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: MColors.white),
                  ),
                ),
                MUserProfileTile(
                    onPressed: () => Get.to(() => const ProfileScreen())),
                const SizedBox(height: Sizes.spaceBtwSections),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  const MSectionHeading(
                    title: MTexts.profileServices,
                    showActionButton: false,
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  MSettingsMenuTile(
                    title: MTexts.nikePageTitle,
                    subtitle: MTexts.nikePageSubTitle,
                    onTap: () async => await launchUrlString(
                      MTexts.nikePageUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  MSettingsMenuTile(
                    title: MTexts.nikeSignUpTitle,
                    subtitle: MTexts.nikeSignUpSubTitle,
                    onTap: () async => await launchUrlString(
                      MTexts.nikeSignUpUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  MSettingsMenuTile(
                    title: MTexts.nikeLastProductsTitle,
                    subtitle: MTexts.nikeLastProductsSubTitle,
                    onTap: () async => await launchUrlString(
                      MTexts.nikeLastProductsUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  MSettingsMenuTile(
                    img: MImages.user,
                    title: MTexts.gitHubTitle,
                    onTap: () async => await launchUrlString(
                      MTexts.gitHubUrl,
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text(MTexts.logout)),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections + 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
