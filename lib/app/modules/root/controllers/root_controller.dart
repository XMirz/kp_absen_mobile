import 'package:get/get.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/routes/app_pages.dart';
import 'package:kp_mobile/app/services/root_services.dart';
import 'package:kp_mobile/app/services/storage_service.dart';

class RootController extends GetxController {
  late String token; // TODO safe with shared prefs
  late RootServices _services;
  final user = User().obs;
  RxInt fragmentIndex = 0.obs;
  init() async {
    final storage = Get.find<StorageService>();
    var res = await storage.retrieveAuthToken();
    token = res as String;
    print('Token : $token');
    if (token.isEmpty) {
      Get.toNamed(Routes.LOGIN);
    }
    _services = RootServices(token);
    var result = await _services.getAuthUser();
    if (result != null) {
      print(result);
      user.value = result;
    }
  }

  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }
}
