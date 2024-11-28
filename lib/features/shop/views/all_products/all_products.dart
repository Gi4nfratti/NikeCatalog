import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/appbar/appbar.dart';
import 'package:moraes_nike_catalog/common/widgets/products/sortable/sortable_products.dart';
import 'package:moraes_nike_catalog/features/shop/controllers/all_products_controller.dart';
import 'package:moraes_nike_catalog/features/shop/models/product_model.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';
import 'package:moraes_nike_catalog/utils/helpers/cloud_helper_functions.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = AllProductsController.instance;
    return Scaffold(
      appBar: MAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              const loader = SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(color: MColors.primary));

              final widget = MCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);

              if (widget != null) return widget;

              final products = snapshot.data!;

              return MSortableProducts(products: products);
            },
          ),
        ),
      ),
    );
  }
}
