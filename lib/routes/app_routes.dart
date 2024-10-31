import 'package:get/get.dart';
import 'package:moraes_nike_catalog/features/authentication/views/login/login.dart';
import 'package:moraes_nike_catalog/features/authentication/views/onboarding/onboarding.dart';
import 'package:moraes_nike_catalog/features/authentication/views/password_configuration/forget_password.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/signup.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/verify_email.dart';
import 'package:moraes_nike_catalog/features/personalization/views/address/address.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/profile.dart';
import 'package:moraes_nike_catalog/features/personalization/views/profile/widgets/change_field.dart';
import 'package:moraes_nike_catalog/features/personalization/views/settings/settings.dart';
import 'package:moraes_nike_catalog/features/shop/views/home/home.dart';
import 'package:moraes_nike_catalog/features/shop/views/order/order.dart';
import 'package:moraes_nike_catalog/features/shop/views/store/store.dart';
import 'package:moraes_nike_catalog/features/shop/views/favourite/favourite.dart';
import 'package:moraes_nike_catalog/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: MRoutes.home, page: () => const HomeScreen()),
    GetPage(name: MRoutes.store, page: () => const StoreScreen()),
    GetPage(name: MRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: MRoutes.settings, page: () => const SettingsScreen()),
    GetPage(name: MRoutes.order, page: () => const OrderView()),
    GetPage(name: MRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: MRoutes.changeField, page: () => const ChangeField()),
    GetPage(name: MRoutes.userAddress, page: () => const UserAddressView()),
    GetPage(name: MRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: MRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: MRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: MRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: MRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
