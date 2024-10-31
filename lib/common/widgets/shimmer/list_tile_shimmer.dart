import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/shimmer_effect.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MListTileShimmer extends StatelessWidget {
  const MListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            MShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: Sizes.spaceBtwItems),
            Column(
              children: [
                MShimmerEffect(width: 100, height: 15),
                SizedBox(width: Sizes.spaceBtwItems / 2),
                MShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}
