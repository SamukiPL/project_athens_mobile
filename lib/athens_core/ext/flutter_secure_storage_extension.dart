import 'package:flutter_secure_storage/flutter_secure_storage.dart';

extension FlutterSecureStorageExtension on FlutterSecureStorage {
  bool _parseBool(String? storageValue) {
    return storageValue != null && storageValue.toLowerCase() == true.toString().toLowerCase();
  }

  Future<bool> readBool({required String key}) async {
    final storageValue = await this.read(key: key);

    return _parseBool(storageValue);
  }
}