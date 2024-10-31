import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/shimmer_effect.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MVerticalProductShimmer extends StatelessWidget {
  const MVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MShimmerEffect(width: 180, height: 180),
                  SizedBox(height: Sizes.spaceBtwItems),
                  MShimmerEffect(width: 160, height: 15),
                  SizedBox(height: Sizes.spaceBtwItems / 2),
                  MShimmerEffect(width: 110, height: 15),
                ],
              ),
            ));
  }
}
