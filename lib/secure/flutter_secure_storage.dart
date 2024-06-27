import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Store JWT
  Future<void> storeJwt({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
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