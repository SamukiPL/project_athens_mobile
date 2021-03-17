// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputies_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeputiesApi implements DeputiesApi {
  _DeputiesApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<DeputyResponse>> getAllDeputies(cadency) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/deputy-aggregator/cadency-deputy/get-all/$cadency',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => DeputyResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<DeputyResponse> getDeputy(cadencyDeputyId) async {
    ArgumentError.checkNotNull(cadencyDeputyId, 'cadencyDeputyId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-deputy/$cadencyDeputyId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeputyResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> putDeputies(cadency, request) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    await _dio.request<void>('/user-aggregator/deputy-subscribe/$cadency',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<List<SubscribedDeputyResponse>> getSubscribedDeputies(cadency) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/user-aggregator/deputy-subscribe/$cadency',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            SubscribedDeputyResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
