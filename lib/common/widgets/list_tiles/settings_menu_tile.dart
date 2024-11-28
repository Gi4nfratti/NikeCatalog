import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/constants/image_strings.dart';

class MSettingsMenuTile extends StatelessWidget {
  const MSettingsMenuTile({
    super.key,
    required this.title,
    this.subtitle = "",
    this.img = MImages.nikeLogo,
    this.trailing,
    this.onTap,
  });

  final String title, subtitle, img;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(height: 28, width: 28, child: Image.asset(img)),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: subtitle.isEmpty
          ? null
          : Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
