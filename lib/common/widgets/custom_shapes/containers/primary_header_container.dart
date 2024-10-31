import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:moraes_nike_catalog/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';

class MPrimaryHeaderContainer extends StatelessWidget {
  const MPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MCurvedEdgeWidget(
      child: Container(
        color: MColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: MCircularContainer(
                  backgroundColor: MColors.textWhite.withOpacity(0.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: MCircularContainer(
                  backgroundColor: MColors.textWhite.withOpacity(0.1)),
            ),
            child
          ],
        ),
      ),
    );
  }
}
