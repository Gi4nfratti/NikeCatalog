import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/shimmer/shimmer_effect.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MHorizontalProductShimmer extends StatelessWidget {
  const MHorizontalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: Sizes.spaceBtwItems,
              ),
          itemCount: itemCount,
          itemBuilder: (_, __) => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MShimmerEffect(width: 120, height: 120),
                  SizedBox(width: Sizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Sizes.spaceBtwItems / 2),
                      MShimmerEffect(width: 160, height: 15),
                      SizedBox(height: Sizes.spaceBtwItems / 2),
                      MShimmerEffect(width: 110, height: 15),
                      SizedBox(height: Sizes.spaceBtwItems / 2),
                      MShimmerEffect(width: 80, height: 15),
                      Spacer()
                    ],
                  )
                ],
              )),
    );
  }
}
