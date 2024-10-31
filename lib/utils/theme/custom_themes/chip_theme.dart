import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';

class MChipTheme {
  MChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: MColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: MColors.grey,
    labelStyle: TextStyle(color: MColors.white),
    selectedColor: Colors.green,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MColors.white,
  );
}
