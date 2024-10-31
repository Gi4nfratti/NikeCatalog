import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/features/shop/views/order/widgets/orders_list.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
          title: Text('Meus Pedidos',
              style: Theme.of(context).textTheme.headlineSmall),
          showBackArrow: true),
      body: const Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: MOrderListItems()),
    );
  }
}
