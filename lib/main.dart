import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kp_mobile/app/services/storage_service.dart';
import 'package:kp_mobile/app/values/colors.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  final storage = await Get.putAsync(() => StorageService().init());
  final authToken = await storage.retrieveAuthToken();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: authToken != null ? Routes.ROOT : Routes.LOGIN,
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
