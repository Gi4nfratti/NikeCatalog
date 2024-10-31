import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/constants/sizes.dart';

class MProfileMenu extends StatelessWidget {
  const MProfileMenu({super.key, required this.title, required this.value});

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwItems / 1.5),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis)),
          Expanded(
              flex: 2,
              child: Text(value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
