import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin ConfigurationDelegate<DATA_TYPE, OUTPUT> {
  String get preferenceName;

  DATA_TYPE? get defaultStorageValue;

  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<DATA_TYPE> fetchPreference(OUTPUT Function(Map<String, dynamic> json)? createObject) async {
    final String? storageValue = await storage.read(key: preferenceName);

    if (storageValue == null || storageValue == '') {
      return Future.value(defaultStorageValue);
    }

    switch(DATA_TYPE) {
      case String: return storageValue as DATA_TYPE;
      case bool: return Future.value(storageValue.toLowerCase() == true.toString().toLowerCase()) as Future<DATA_TYPE>;
      case DateTime: return Future.value(DateTime.parse(storageValue)) as Future<DATA_TYPE>;
      default:
        final json = jsonDecode(storageValue);

        if (createObject != null) {
          if (json is List) {
            final DATA_TYPE list = json.map((jsonObject) => createObject(jsonObject)).toList() as DATA_TYPE;

            return list;
          } else {
            return createObject(json) as DATA_TYPE;
          }
        }

        throw new UnimplementedError();
    }
  }

  Future<void> updatePreference(DATA_TYPE preferences) async {
    switch(DATA_TYPE) {
      case DateTime: return storage.write(key: preferenceName, value: (preferences as DateTime).toIso8601String());
      default: return storage.write(key: preferenceName, value: jsonEncode(preferences));
    }
  }

  Future<void> clearPreference() async {
    storage.delete(key: preferenceName);
  }

  Future<void> deletePreference() async {
    await storage.delete(key: preferenceName);
  }
}
