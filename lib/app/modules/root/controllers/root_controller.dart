import 'package:get/get.dart';
import 'package:kp_mobile/app/data/models/user.dart';
import 'package:kp_mobile/app/services/root_services.dart';

class RootController extends GetxController {
  late String token; // TODO safe with shared prefs
  late RootServices _services;
  late User user;
  RxInt fragmentIndex = 0.obs;
  init() async {
    token = Get.arguments['token'];
    _services = RootServices(token);
    var result = await _services.getAuthUser();
    if (result != null) {
      user = result;
    }
  }

  void changePageIndex(int index) {
    fragmentIndex.value = index;
  }
}
