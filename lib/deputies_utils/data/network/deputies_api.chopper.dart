// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputies_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$DeputiesApi extends DeputiesApi {
  _$DeputiesApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DeputiesApi;

  @override
  Future<Response<dynamic>> getAllDeputies(int cadency) {
    final $url = '/deputy-aggregator/cadency-deputy/get-all/$cadency';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> putDeputies(
      int cadency, PutDeputiesRequest request) {
    final $url = '/user-aggregator/deputy-subscribe/$cadency';
    final $body = request;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSubscribedDeputies(int cadency) {
    final $url = '/user-aggregator/deputy-subscribe/$cadency';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
