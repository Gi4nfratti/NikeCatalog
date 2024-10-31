import 'package:flutter/material.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/appbar_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/chip_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/text_field_theme.dart';
import 'package:moraes_nike_catalog/utils/theme/custom_themes/text_theme.dart';

class MAppTheme {
  MAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: MTextTheme.lightTextTheme,
    chipTheme: MChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: MAppBarTheme.lightAppBarTheme,
    checkboxTheme: MCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MTextFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: MTextTheme.darkTextTheme,
    chipTheme: MChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: MAppBarTheme.darkAppBarTheme,
    checkboxTheme: MCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: MElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MTextFieldTheme.darkInputDecorationTheme,
  );
}
