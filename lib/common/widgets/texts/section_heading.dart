import 'package:flutter/material.dart';

class MSectionHeading extends StatelessWidget {
  const MSectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    this.title = "",
    this.buttonTitle = 'Ver todos',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final String? title;
  final String buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      if (title!.isNotEmpty)
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      if (showActionButton)
        TextButton(onPressed: onPressed, child: Text(buttonTitle))
    ]);
  }
}
