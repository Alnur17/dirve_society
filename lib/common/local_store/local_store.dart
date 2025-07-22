import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final _box = GetStorage();

  // data save kore
  static saveData({required String key, required dynamic data}) async {
    await _box.write(key.toString(), data);
  }

  // data niye asa
  static getData({required String key}) {
    return _box.read(key.toString());
  }

  static readData({required String key}) {
    return _box.read(key.toString());
  }

  static removeData({required String key}) async {
    // data remove hoy
    await _box.remove(key.toString());
  }
}
