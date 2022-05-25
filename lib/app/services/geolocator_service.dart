import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kp_mobile/app/utils/helper.dart';

class GeolocatorService extends Geolocator {
  Future<GeolocatorService> init() async {
    return this;
  }

  Future<Position> getCurrentPosition() async {
    final currentPost = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    return currentPost;
  }

// Request permission
  Future<bool> getPermission() async {
    // Cek jika lokasi dimatikan
    bool locationServiceEnabled;
    locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      await Helper.showConfirmationDialog(
          title: 'Perhatian!',
          showCancel: false,
          onCancel: () {},
          barrierDismissible: false,
          message:
              'Aplikasi ini membutuhkan akses lokasi. Silahkan aktifkan akses lokasi perangkat ini.',
          textConfirm: 'Keluar',
          onConfirm: () {
            SystemNavigator.pop(animated: true);
          });
      return false;
    }

    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    print('First');
    inspect(permission);
    // Chwck permission for the first time
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }
    // Jika jika permmission diijinkan
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      inspect(permission);
      await Helper.showConfirmationDialog(
          title: 'Perhatian!',
          showCancel: false,
          onCancel: () {},
          barrierDismissible: false,
          message:
              'Aplikasi ini membutuhkan akses lokasi. Silahkan beri ijin aplikasi ini untuk mengakses lokasi perangkat ini.',
          textConfirm: 'Keluar',
          onConfirm: () {
            SystemNavigator.pop(animated: true);
          });
      return false;
    }
    return true;
  }
}
