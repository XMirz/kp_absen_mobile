import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:kp_mobile/app/utils/helper.dart';
import 'package:kp_mobile/app/widgets/text.dart';
import 'package:map_launcher/map_launcher.dart';

class RootController extends GetxController {
  GeolocatorService geolocator = Get.find<GeolocatorService>();
  late String token;
  late RootServices _services;
  late Position currentPosition;

  TextEditingController presenceController = TextEditingController();

  RxBool updatePasswordObsecured =
      true.obs; // Obsecure status for update password view,
  Rx<User> user = User().obs;
  Rx<Configuration> configuration = Configuration().obs;
  Rx<Presence?> todayPresence = Rx<Presence?>(null);
  RxList<Presence> presencesHistory = <Presence>[].obs;
  RxInt fragmentIndex = 0.obs;
  RxDouble metersFromOffice = 0.0.obs;
  RxString distanceFromOfficeText = '-'.obs;
  RxString presenceType = 'presence'.obs;

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

  Future<void> handleFab() async {
    Get.dialog(SafeArea(
      child: Center(
        child: Container(
          width: Get.width * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TextHeadingSmall(
                    title: 'Presensi Hari Ini',
                    textAlign: TextAlign.center,
                  ),
                ),
                spaceY(20),
                TextBody(
                  title: 'Presensi',
                ),
                spaceY(4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: presenceType.value,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(8),
                    underline: Container(),
                    items: [
                      DropdownMenuItem<String>(
                        child: TextBodyLarge(title: 'Hadir'),
                        value: 'presence',
                      ),
                      DropdownMenuItem<String>(
                        child: TextBodyLarge(title: 'Izin'),
                        value: 'permit',
                      ),
                      DropdownMenuItem<String>(
                        child: TextBodyLarge(title: 'Sakit'),
                        value: 'diseased',
                      ),
                    ],
                    onChanged: (value) {
                      presenceType.value = value!;
                    },
                  ),
                ),
                spaceY(8),
                TextBody(
                  title: 'Keterangan',
                ),
                spaceY(4),
                TextField(
                  controller: presenceController,
                  maxLines: 4,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.3)),
                    ),
                  ),
                ),
                spaceY(8),
                ElevatedButton(
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 500), () async {
                      await checkIn();
                      presenceController.text = '';
                    });
                    Get.back();
                  },
                  child: TextBodyLarge(title: 'Kirim', color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> checkIn() async {
    EasyLoading.show(status: 'Mohon tunggu...');
    var todayPresence = await _services.checkIn(
        type: presenceType.value,
        description: presenceController.text,
        metersDistance: metersFromOffice.value,
        currentLocation: {
          'longitude': currentPosition.longitude,
          'latitude': currentPosition.latitude,
        });
    await Future.delayed(Duration(seconds: 3)); // Show loading longeer :v
    EasyLoading.dismiss();
    if (todayPresence != null) {
      this.todayPresence.value = todayPresence;
      EasyLoading.showSuccess('Presensi berhasil dilakukan');
      return;
    }
    EasyLoading.showError('Presensi gagal dilakukan');
  }

  Future<void> checkOut() async {
    EasyLoading.show(status: 'Mohon tunggu...');
    var todayPresence = await _services.checkOut(
        id: this.todayPresence.value!.id!,
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
