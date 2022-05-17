// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:kp_mobile/app/modules/login/bindings/login_binding.dart';
import 'package:kp_mobile/app/modules/login/views/login_view.dart';

import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
