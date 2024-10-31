import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';

class MRatingBarIndicator extends StatelessWidget {
  const MRatingBarIndicator({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: rating,
        itemSize: 20,
        unratedColor: MColors.grey,
        itemBuilder: (_, __) => const Icon(
              Icons.star,
              color: MColors.primary,
            ));
  }
}