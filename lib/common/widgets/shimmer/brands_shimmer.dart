import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/layouts/grid_layout.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/shimmer_effect.dart';

class MBrandsShimmer extends StatelessWidget {
  const MBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return MGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const MShimmerEffect(width: 300, height: 80),
    );
  }
}
