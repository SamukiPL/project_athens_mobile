import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tile_storage.dart';

mixin ConfigurationDelegate<T, R> {
  String get preferenceName => '';
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<T> fetchPreference(R Function(Map<String, dynamic> json)? createObject) async {
    final String storageValue = await storage.read(key: preferenceName);
    // return storage.read(key: preferenceName);

    final dynamic result;

    switch(T) {
      case String: return storageValue as T;
      case bool: return Future.value(storageValue != null && storageValue.toLowerCase() == true.toString().toLowerCase()) as Future<T>;
      default:
        final json = jsonDecode(storageValue);

        if (createObject != null) {
          if (json is List) {
            final T list = json.map((jsonObject) => createObject(jsonObject) as R).toList() as T;

            return Future.value(list) as Future<T>;
          } else {
            return Future.value(createObject(json) as T);
          }
        } else {
          return storageValue as T;
        }
    }
    return storageValue as T;
  }

  Future<void> updatePreference(List<DashboardTileStorage> tiles) async {
    final stringified = jsonEncode(tiles);

    await storage.write(key: preferenceName, value: stringified);
  }
}