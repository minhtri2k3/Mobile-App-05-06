import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureStorage {
  final _storage = FlutterSecureStorage();

  // Store JWT
  Future<void> storeJwt(String jwt) async {
    await _storage.write(key: 'jwt', value: jwt);
  }

  // Retrieve JWT
  Future<String?> retrieveJwt() async {
    return await _storage.read(key: 'jwt');
  }

  // Delete JWT
  Future<void> deleteJwt() async {
    await _storage.delete(key: 'jwt');
  }
}