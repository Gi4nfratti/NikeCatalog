import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:moraes_nike_catalog/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:moraes_nike_catalog/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/views/address/address.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/profile.dart';
import 'package:moraes_nike_catalog/features/shop/views/order/order.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

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
                    'Minha Conta',
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
                    title: 'Configurações da Conta',
                    showActionButton: false,
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  MSettingsMenuTile(
                    icon: Icons.home_outlined,
                    title: 'Meu Endereço',
                    subtitle: 'Configure o endereço de entrega',
                    onTap: () => Get.to(() => const UserAddressView()),
                  ),
                  MSettingsMenuTile(
                    icon: Icons.shopping_cart_outlined,
                    title: 'Meu Carrinho',
                    subtitle: 'Adicione e remova produtos do carrinho',
                    onTap: () {},
                  ),
                  MSettingsMenuTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Meus Pedidos',
                    subtitle: 'Veja todos os seus pedidos',
                    onTap: () => Get.to(() => const OrderView()),
                  ),
                  MSettingsMenuTile(
                    icon: Icons.attach_money_outlined,
                    title: 'Conta Bancária',
                    subtitle: 'Veja seus limites e saldos',
                    onTap: () {},
                  ),
                  MSettingsMenuTile(
                    icon: Icons.discount_outlined,
                    title: 'Meus Cupons',
                    subtitle: 'Veja a lista de cupons de desconto',
                    onTap: () {},
                  ),
                  MSettingsMenuTile(
                    icon: Icons.notification_add_outlined,
                    title: 'Notificações',
                    subtitle: 'Configure suas notificações',
                    onTap: () {},
                  ),
                  MSettingsMenuTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacidade da Conta',
                    subtitle: 'Gerencie suas contas',
                    onTap: () {},
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  const MSectionHeading(
                      title: 'Configurações do App', showActionButton: false),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  const MSettingsMenuTile(
                      icon: Icons.upload_file_outlined,
                      title: "Carregar Dados",
                      subtitle: 'Carregue arquivos para o seu Banco de Dados'),
                  MSettingsMenuTile(
                    icon: Icons.location_on_outlined,
                    title: "Geolocalização",
                    subtitle:
                        'Configure suas recomendações baseadas na sua localização',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  MSettingsMenuTile(
                    icon: Icons.security_outlined,
                    title: "Modo Seguro",
                    subtitle: 'Ative o modo seguro',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  MSettingsMenuTile(
                    icon: Icons.image,
                    title: "Qualidade das imagens em HD",
                    subtitle:
                        'Configure para que as imagens esteja em alta resolução',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () =>
                            AuthenticationRepository.instance.logout(),
                        child: const Text('Logout')),
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
