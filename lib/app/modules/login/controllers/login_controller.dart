import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/services/auth_service.dart';
import 'package:kp_mobile/app/services/storage_service.dart';
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/values/colors.dart';

class LoginController extends GetxController {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  RxBool obsecurePassword = true.obs;
  RxBool isLoading = false.obs;

  final AuthService _authService = AuthService();

  Future<void> login() async {
    Get.closeAllSnackbars();
    isLoading.value = true;
    EasyLoading.show(status: 'Mohon tunggu...');
    checkAuthInput(); // Check if user input not null
    var token = await _authService.getAuthToken({
      "email": emailCon.text,
      "password": passwordCon.text,
      "device_name": "Anu"
    });
    EasyLoading.dismiss();
    isLoading.value = false;
    if (token == null) {
      Helper.showSnackBar('Username atau password salah',
          backgroundColor: AppColor.error);
      return;
    }

    final storage = Get.find<StorageService>();
    storage.saveAuthToken(token);
    Get.offAndToNamed(Routes.ROOT);
  }

  void checkAuthInput() {
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
  }
}
