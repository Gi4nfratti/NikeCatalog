import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moraes_nike_catalog/data/repositories/user/user_repository.dart';
import 'package:moraes_nike_catalog/features/authentication/views/login/login.dart';
import 'package:moraes_nike_catalog/features/authentication/views/onboarding/onboarding.dart';
import 'package:moraes_nike_catalog/features/authentication/views/signup/verify_email.dart';
import 'package:moraes_nike_catalog/navigation_menu.dart';
import 'package:moraes_nike_catalog/utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User get authUser => _auth.currentUser!;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        await MLocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credentials);
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (e) {
      if (kDebugMode) print('Algo deu errado. Por favor tente novamente - $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (_) {
      throw 'MFirebaseAuthException - Erro';
    } on FirebaseException catch (_) {
      throw 'MFirebaseException - Erro';
    } on FormatException catch (_) {
      throw 'MFormatException - Erro';
    } on PlatformException catch (_) {
      throw 'MPlatformException - Erro';
    } catch (_) {
      throw 'Algo deu errado. Por favor tente novamente';
    }
  }
}
