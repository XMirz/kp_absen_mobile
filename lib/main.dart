import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kp_mobile/app/services/geolocator_service.dart';
import 'package:kp_mobile/app/services/storage_service.dart';
import 'package:kp_mobile/app/values/colors.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';
  await GetStorage.init();
  final storage = await Get.putAsync(() => StorageService().init());
  final authToken = await storage.retrieveAuthToken();
  Get.putAsync(() => GeolocatorService().init());
  runApp(
    GetMaterialApp(
      onInit: (() {
        EasyLoading.instance
          ..maskType = EasyLoadingMaskType.black
          ..indicatorType = EasyLoadingIndicatorType.threeBounce
          ..animationStyle = EasyLoadingAnimationStyle.scale
          ..contentPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 28)
          ..loadingStyle = EasyLoadingStyle.light;
      }),
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
      builder: EasyLoading.init(),
    ),
  );
}
