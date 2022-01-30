import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin ConfigurationDelegate<T, R> {
  String get preferenceName;

  T? get defaultStorageValue;

  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<T> fetchPreference(R Function(Map<String, dynamic> json)? createObject) async {
    final String? storageValue = await storage.read(key: preferenceName);

    if (storageValue == null || storageValue == '') {
      return Future.value(defaultStorageValue);
    }

    switch(T) {
      case String: return storageValue as T;
      case bool: return Future.value(storageValue.toLowerCase() == true.toString().toLowerCase()) as Future<T>;
      default:
        final json = jsonDecode(storageValue);

        if (createObject != null) {
          if (json is List) {
            final T list = json.map((jsonObject) => createObject(jsonObject)).toList() as T;

            return list;
          } else {
            return createObject(json) as T;
          }
        }

        throw new UnimplementedError();
    }
  }

  Future<void> updatePreference(T preferences) async {
    final stringified = jsonEncode(preferences);

    await storage.write(key: preferenceName, value: stringified);
  }

  Future<void> deletePreference() async {
    await storage.delete(key: preferenceName);
  }
}
