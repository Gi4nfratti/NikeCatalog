import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:moraes_nike_catalog/common/widgets/loaders/animation_loader.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/product/order_controller.dart';
import 'package:moraes_nike_catalog/navigation_menu.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';
import 'package:moraes_nike_catalog/utils/helpers/helper_functions.dart';

class MOrderListItems extends StatelessWidget {
  const MOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = MHelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (_, snapshot) {
          final emptyWidget = MAnimationLoaderWidget(
            text: 'A lista está vazia...',
            animation: MImages.lProcInfo,
            showAction: true,
            actionText: 'Vamos adicionar alguns...',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          final response = MCloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;

          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, index) =>
                  const SizedBox(height: Sizes.spaceBtwItems),
              itemBuilder: (_, index) {
                final order = orders[index];
                return MRoundedContainer(
                  showBorder: true,
                  padding: const EdgeInsets.all(Sizes.md),
                  backgroundColor: dark ? MColors.dark : MColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.delivery_dining_outlined),
                          const SizedBox(width: Sizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order.orderStatusText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(
                                            color: MColors.primary,
                                            fontWeightDelta: 1)),
                                Text(order.formattedOrderDate,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward_ios_outlined,
                                  size: Sizes.iconSm)),
                        ],
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.delivery_dining_outlined),
                                const SizedBox(width: Sizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Pedido',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text(order.id,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_rounded),
                                const SizedBox(width: Sizes.spaceBtwItems / 2),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Data da Entrega',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text(order.formattedDeliveryDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
