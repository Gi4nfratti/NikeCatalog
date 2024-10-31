import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/checkout_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/payment_method_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MPaymentTile extends StatelessWidget {
  const MPaymentTile({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;
  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: MRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: MHelperFunctions.isDarkMode(context)
            ? MColors.light
            : MColors.white,
        padding: const EdgeInsets.all(Sizes.sm),
        child:
            Image(image: AssetImage(paymentMethod.image), fit: BoxFit.contain),
      ),
      title: Text(paymentMethod.name),
      trailing: const Icon(Icons.arrow_right_alt_outlined),
    );
  }
}
