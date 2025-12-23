import 'package:get_storage/get_storage.dart';

class LocalAuthInfo {
  Future<void> saveInfo({
    required String email,
    required String password,
  }) async {
    final storage = GetStorage();
    storage.write('email', email);
    storage.write('password', password);
  }

  Future<void> removeInfo() async {
    final storage = GetStorage();
    storage.remove('email');
    storage.remove('password');
    storage.write('token', "");
  }

  String? readEmail() {
    final storage = GetStorage();

    return storage.read('email');
  }

  String? readPassword() {
    final storage = GetStorage();
    return storage.read('password');
  }
}
