import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moraes_nike_catalog/bindings/general_binding.dart';
import 'package:moraes_nike_catalog/routes/app_routes.dart';
import 'package:moraes_nike_catalog/utils/constants/colors.dart';
import 'package:moraes_nike_catalog/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MAppTheme.lightTheme,
      darkTheme: MAppTheme.darkTheme,
      getPages: AppRoutes.pages,
      initialBinding: GeneralBinding(),
      home: const Scaffold(
        backgroundColor: MColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: MColors.white,
          ),
        ),
      ),
    );
  }
}