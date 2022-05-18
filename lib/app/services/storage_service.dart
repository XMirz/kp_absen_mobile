import 'package:get_storage/get_storage.dart';

class StorageService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    // _box.write(taskKey, []);
    _box.writeIfNull('prefs', {});
    return this;
  }

  Future<dynamic> getPrefs() async {
    var prefs = await _box.read('prefs');
    return prefs;
  }

  Future<String?> retrieveAuthToken() async {
    var prefs = await getPrefs();
    var tokenKey = prefs['token'];
    if (tokenKey != null) {
      return tokenKey;
    }
    return null;
  }

  Future saveAuthToken(String tokenKey) async {
    var prefs = await getPrefs();
    prefs['token'] = tokenKey;
    await _box.write('prefs', prefs);
  }
}
