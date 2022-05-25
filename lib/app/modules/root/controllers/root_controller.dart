import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/data/models/company.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/services/geolocator_service.dart';
import 'package:kp_mobile/app/services/root_services.dart';
import 'package:kp_mobile/app/services/storage_service.dart';

class RootController extends GetxController {
  GeolocatorService geolocator = Get.find<GeolocatorService>();
  late String token;
  late RootServices _services;
  late Position currentPosition;
  Rx<User> user = User().obs;
  Rx<Company> company = Company().obs;
  RxInt fragmentIndex = 0.obs;
  RxString distanceFromOffice = '-'.obs;

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
    }
    // Get permission to acces location
    geolocator.getPermission();
    // Set currentLocation
    currentPosition = await geolocator.getCurrentPosition();
    // Determine distance
    distanceFromOffice.value = getDistanceFromOffice();
    super.onInit();
  }

  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }

  String getDistanceFromOffice() {
    double distance = Geolocator.distanceBetween(
      double.parse(company.value.latitude!),
      double.parse(company.value.longitude!),
      currentPosition.latitude,
      currentPosition.longitude,
    );
    if (distance > 1000) {
      return '${(distance / 1000).toStringAsFixed(2)} km';
    }
    return '${distance.toStringAsFixed(2)} m';
  }
}
