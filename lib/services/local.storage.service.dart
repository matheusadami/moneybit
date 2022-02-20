import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<List<String>?> getStringList(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.getStringList(key);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    var shared = await SharedPreferences.getInstance();
    return await shared.setStringList(key, value);
  }
}
