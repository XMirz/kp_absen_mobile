import 'dart:developer';

import 'package:get/get.dart';
import 'package:kp_mobile/app/data/models/company.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/services/root_services.dart';
import 'package:kp_mobile/app/services/storage_service.dart';

class RootController extends GetxController {
  late String token;
  late RootServices _services;
  final user = User().obs;
  final company = Company().obs;
  RxInt fragmentIndex = 0.obs;
  @override
  void onInit() async {
    final storage = Get.find<StorageService>();
    var res = await storage.retrieveAuthToken();
    token = res as String;
    if (token.isEmpty) {
      Get.toNamed(Routes.LOGIN);
    }
    _services = RootServices(token);
    var fetchUserData = await _services.getAuthUser();
    if (fetchUserData != null) {
      user.value = fetchUserData;
    }
    var fetchCompanyData = await _services.getInitialData();
    if (fetchCompanyData != null) {
      company.value = fetchCompanyData;
      inspect(company.value);
      super.onInit();
    }
  }

  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }
}
