import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/data/models/configuration.dart';
import 'package:kp_mobile/app/data/models/presence.dart';
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
  RxBool isLoading = false.obs;
  Rx<User> user = User().obs;
  Rx<Configuration> configuration = Configuration().obs;
  Rx<Presence> todayPresence = Presence().obs;
  RxInt fragmentIndex = 0.obs;
  RxDouble metersFromOffice = 0.0.obs;
  RxString distanceFromOfficeText = '-'.obs;

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

    // get initialConfigData
    var fetchConfigurationData = await _services.getInitialData();
    if (fetchConfigurationData != null) {
      configuration.value = fetchConfigurationData;
      if (fetchConfigurationData.todayPresence != null) {
        todayPresence.value =
            Presence.fromMap(fetchConfigurationData.todayPresence!);
      }
    }
    // Get permission to acces location
    await geolocator.getPermission();
    // Set currentLocation
    currentPosition = await geolocator.getCurrentPosition();
    // Determine distance
    metersFromOffice.value = getDistanceFromOffice();
    distanceFromOfficeText.value =
        getDistanceFromOfficeText(metersFromOffice.value);
    super.onInit();
  }

  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }

  double getDistanceFromOffice() {
    double distance = Geolocator.distanceBetween(
      double.parse(configuration.value.latitude!),
      double.parse(configuration.value.longitude!),
      currentPosition.latitude,
      currentPosition.longitude,
    );
    return distance;
  }

  String getDistanceFromOfficeText(distance) {
    if (distance > 1000) {
      return '${(distance / 1000).toStringAsFixed(2)} km';
    }
    return '${distance.toStringAsFixed(2)} m';
  }

  Future<void> checkIn() async {
    EasyLoading.show(status: 'Mohon tunggu...');
    var todayPresence = await _services
        .checkInOut(metersDistance: metersFromOffice.value, currentLocation: {
      'longitude': currentPosition.longitude,
      'latitude': currentPosition.latitude,
    });
    EasyLoading.dismiss();
    if (todayPresence != null) {
      this.todayPresence.value = todayPresence;
      EasyLoading.showSuccess('Absensi masuk berhasil');
      return;
    }
    EasyLoading.showError('Absensi masuk gagal.');
  }

  Future<void> checkOut() async {
    EasyLoading.show(status: 'Mohon tunggu...');
    var todayPresence = await _services.checkInOut(
        id: this.todayPresence.value.id,
        metersDistance: metersFromOffice.value,
        currentLocation: {
          'longitude': currentPosition.longitude,
          'latitude': currentPosition.latitude,
        });
    if (todayPresence != null) {
      this.todayPresence.value = todayPresence;
      configuration.value = configuration.value.copyWith(eligible: false);
      EasyLoading.showSuccess('Absensi keluar berhasil.');
      return;
    }
    EasyLoading.showError('Absensi keluar gagal.');
  }
}
