import 'dart:developer';

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
import 'package:map_launcher/map_launcher.dart';

class RootController extends GetxController {
  GeolocatorService geolocator = Get.find<GeolocatorService>();
  late String token;
  late RootServices _services;
  late Position currentPosition;
  RxBool updatePasswordObsecured =
      true.obs; // Obsecure status for update password view,
  Rx<User> user = User().obs;
  Rx<Configuration> configuration = Configuration().obs;
  Rx<Presence> todayPresence = Presence().obs;
  RxList<Presence> presencesHistory = <Presence>[].obs;
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

    await getSetInitialData();

    super.onInit();
  }

  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }

  Future<void> getSetInitialData() async {
    // Clear current state
    todayPresence.value = Presence();
    presencesHistory.clear();
    // get initialConfigData
    var fetchConfigurationData = await _services.getInitialData();
    if (fetchConfigurationData != null) {
      inspect(fetchConfigurationData);
      configuration.value = fetchConfigurationData;
      if (fetchConfigurationData.todayPresence != null) {
        todayPresence.value =
            Presence.fromMap(fetchConfigurationData.todayPresence!);
      }
      // Set last five presence history
      if (configuration.value.presencesHistory != null) {
        configuration.value.presencesHistory?.forEach((mapPresence) {
          presencesHistory.add(Presence.fromMap(mapPresence!));
        });
      }
    }

    // Get permission to acces location
    await geolocator.getPermission();
    // Set currentLocation
    currentPosition = await geolocator.getCurrentPosition();
    // Determine distance
    metersFromOffice.value = getDistanceFromOffice();
    distanceFromOfficeText.value =
        getDistanceFromOfficeText(metersFromOffice.value.toInt());
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

  String getDistanceFromOfficeText(int distance) {
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
    await Future.delayed(Duration(seconds: 3)); // Show loading longeer :v
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
    await Future.delayed(Duration(seconds: 3)); // Show loading longeer :v
    EasyLoading.dismiss();
    if (todayPresence != null) {
      this.todayPresence.value = todayPresence;
      configuration.value = configuration.value.copyWith(eligible: false);
      EasyLoading.showSuccess('Absensi keluar berhasil.');
      getSetInitialData();
      return;
    }
    EasyLoading.showError('Absensi keluar gagal.');
  }

  Future<void> logout() async {
    bool isLoggedOut = await _services.logout();
    if (isLoggedOut) {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  Future<void> updatePassword(data) async {
    EasyLoading.show(status: 'Mohon tunggu...');
    bool isPasswordUpdateSucces = await _services.updatePassword(data);
    EasyLoading.dismiss();
    if (isPasswordUpdateSucces) {
      EasyLoading.showSuccess('Berhasil memperbarui password.');
      Get.back();
      return;
    }
    EasyLoading.showError('Gagal memperbarui password.');
  }

  Future<void> openMap(
      {Coords? destination, Coords? coords, String? title}) async {
    final availableMap = await MapLauncher.installedMaps;
    if (destination != null) {
      await availableMap.first.showDirections(
        destination: destination,
      );
    } else {
      assert(coords != null && title != null);
      await availableMap.first.showMarker(coords: coords!, title: title!);
    }
  }

  String get profileUrl => user.value.profile != null
      ? user.value.profile!
      : "https://ui-avatars.com/api/?background=0D8ABC&color=fff&size=256&name=${user.value.name}";
}
