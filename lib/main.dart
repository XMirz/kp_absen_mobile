import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:kp_mobile/app/values/colors.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  dynamic data = null;
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: data != null ? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.routes,
      theme: ThemeData(
        fontFamily: 'inter',
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppColor.accent,
          backgroundColor: Colors.white,
          primaryColorDark: AppColor.secondary,
        ),
      ),
    ),
  );
}
