import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/address_controller.dart';
import 'package:moraes_nike_catalog/features/personalization/models/address_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MSingleAddress extends StatelessWidget {
  const MSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = MHelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == address.id;
      return InkWell(
        onTap: onTap,
        child: MRoundedContainer(
          width: double.infinity,
          padding: const EdgeInsets.all(Sizes.md),
          showBorder: true,
          backgroundColor: selectedAddress
              ? MColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? MColors.darkerGrey
                  : MColors.grey,
          margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAddress ? Icons.domain_verification_outlined : null,
                  color: selectedAddress
                      ? dark
                          ? MColors.light
                          : MColors.dark.withOpacity(0.6)
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: Sizes.sm / 2),
                  Text(address.formattedPhoneNo,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: Sizes.sm / 2),
                  Text(address.toString(), softWrap: true),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
