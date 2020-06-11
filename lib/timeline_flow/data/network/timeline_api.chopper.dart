// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TimelineApi extends TimelineApi {
  _$TimelineApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TimelineApi;

  @override
  Future<Response<dynamic>> getAllDeputies(int cadency, String date) {
    final $url = '/user-aggregator/timeline/$cadency/$date';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
