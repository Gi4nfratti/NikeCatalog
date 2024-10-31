import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/payment/payment_tile.dart';
import 'package:moraes_nike_catalog/common/widgets/texts/section_heading.dart';
import 'package:moraes_nike_catalog/features/shop/models/payment_method_model.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: MImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(Sizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MSectionHeading(
                        title: 'Como deseja pagar?', showActionButton: false),
                    SizedBox(height: Sizes.spaceBtwSections),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Paypal', image: MImages.paypal)),
                    SizedBox(height: Sizes.spaceBtwItems / 2),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Visa', image: MImages.visa)),
                    SizedBox(height: Sizes.spaceBtwItems / 2),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Google Pay', image: MImages.googlePay)),
                    SizedBox(height: Sizes.spaceBtwItems / 2),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Credit Card', image: MImages.creditCard)),
                    SizedBox(height: Sizes.spaceBtwItems / 2),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Apple Pay', image: MImages.applePay)),
                    SizedBox(height: Sizes.spaceBtwItems / 2),
                    MPaymentTile(
                        paymentMethod: PaymentMethodModel(
                            name: 'Mastercard', image: MImages.mastercard)),
                    SizedBox(height: Sizes.spaceBtwItems / 2),
                    SizedBox(height: Sizes.spaceBtwSections),
                  ],
                ),
              ),
            ));
  }
}
