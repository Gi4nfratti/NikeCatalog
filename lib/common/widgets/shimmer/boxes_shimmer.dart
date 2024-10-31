import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/shimmer_effect.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MBoxesShimmer extends StatelessWidget {
  const MBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: MShimmerEffect(width: 150, height: 110)),
            SizedBox(width: Sizes.spaceBtwItems),
            Expanded(child: MShimmerEffect(width: 150, height: 110)),
            SizedBox(width: Sizes.spaceBtwItems),
            Expanded(child: MShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
