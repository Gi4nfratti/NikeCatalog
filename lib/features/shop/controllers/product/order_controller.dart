import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/success_screen/success_screen.dart';
import 'package:moraes_nike_catalog/data/repositories/authentication/authentication_repository.dart';
import 'package:moraes_nike_catalog/data/repositories/orders/order_repository.dart';
import 'package:moraes_nike_catalog/features/personalization/controllers/address_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/cart_controller.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/checkout_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/order_model.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/home.dart';
import 'package:moraes_nike_catalog/navigation_menu.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/popups/full_screen_loader.dart';
import 'package:moraes_nike_catalog/utils/popups/loaders.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      MLoaders.warningSnackBar(title: 'Ah Não!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      MFullScreenLoader.openLoadingDialog('Processando...', MImages.lProcInfo);
      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );
      await orderRepository.saveOrder(order, userId);

      cartController.clearCart();
      Get.off(() => SuccessScreen(
          image: MImages.successEmailAnimation,
          title: 'Pagamento Confirmado',
          subTitle: 'Seu pagamento foi concluído',
          onPressed: () => Get.offAll(() => const NavigationMenu())));
    } catch (e) {
      MLoaders.errorSnackBar(title: 'Ah Não', message: e.toString());
    }
  }
}
