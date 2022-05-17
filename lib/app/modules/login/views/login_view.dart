import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:kp_mobile/app/values/colors.dart';
import 'package:kp_mobile/app/values/styles.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/gedung_walikota.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              height: Get.size.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [AppColor.accent, Colors.transparent],
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Text(
                'Halo,\nSilahkan masuk.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 36, bottom: 8),
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masuk',
                style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 18,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColor.secondaryExtraLight,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  controller: controller.emailCon,
                  maxLines: 1,
                  style: TextStyle(fontSize: 16, color: AppColor.secondary),
                  decoration: InputDecoration(
                      hintText: 'youremail@email.com',
                      label: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.secondary,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // Password
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColor.secondaryExtraLight,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: Obx(
                  () => TextField(
                    controller: controller.passwordCon,
                    obscureText: controller.obsecurePassword.value,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16, color: AppColor.secondary),
                    decoration: InputDecoration(
                      hintText: '********',
                      label: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColor.secondary,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.obsecurePassword.value =
                                !controller.obsecurePassword.value;
                          },
                          icon: (controller.obsecurePassword.value)
                              ? HeroIcon(
                                  HeroIcons.eye,
                                  color: AppColor.secondary,
                                )
                              : HeroIcon(
                                  HeroIcons.eyeOff,
                                  color: AppColor.secondary,
                                )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: Get.size.width,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.all(controller.isLoading.value ? 6 : 12),
                      elevation: 0,
                      primary: AppColor.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (controller.isLoading.isFalse) {
                        controller.login();
                      }
                    },
                    child: controller.isLoading.value
                        ? Container(
                            child: CircularProgressIndicator(
                              color: AppColor.secondaryExtraLight,
                            ),
                          )
                        : Text(
                            'Masuk',
                            style: TextStyle(
                                fontSize: 16, fontFamily: FontFamily.poppins),
                          ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
