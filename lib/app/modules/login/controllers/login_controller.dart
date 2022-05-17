import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';

class LoginController extends GetxController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  RxBool obsecurePassword = true.obs;
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    Get.closeAllSnackbars();
    isLoading.value = true;
    if (emailCon.text.isEmpty && passwordCon.text.isEmpty) {
      isLoading.value = false;
      Helper.showSnackBar('Masukkan email dan password!',
          backgroundColor: AppColor.error);
      return;
    }
    if (!emailCon.text.isEmail) {
      isLoading.value = false;
      Helper.showSnackBar('Masukkan email yang valid!',
          backgroundColor: AppColor.error);
      return;
    }
    if (passwordCon.text.isEmpty) {
      isLoading.value = false;
      Helper.showSnackBar('Masukkan password!',
          backgroundColor: AppColor.error);
      return;
    }
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: emailCon.text,
        password: passwordCon.text,
      );
      if (credential.user != null) {
        // TODO email verification
        isLoading.value = false;
        Get.toNamed(Routes.ROOT);
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        Helper.showSnackBar('Akun tidak ditemukan!',
            backgroundColor: AppColor.error);
      } else if (e.code == 'wrong-password') {
        Helper.showSnackBar('Password yang anda masukkan salah!',
            backgroundColor: AppColor.error);
      }
    } catch (e) {
      Helper.showSnackBar('Terjadi kesalahan pada sistem!',
          backgroundColor: AppColor.error);
    }
  }
}
