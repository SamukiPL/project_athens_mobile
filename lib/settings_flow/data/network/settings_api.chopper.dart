// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SettingsApi extends SettingsApi {
  _$SettingsApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SettingsApi;

  @override
  Future<Response<dynamic>> logout() {
    final $url = '/user-aggregator/auth/logout';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
