// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputies_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeputiesApi implements DeputiesApi {
  _DeputiesApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<DeputyResponse>> getAllDeputies(cadency) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<DeputyResponse>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options,
                    '/deputy-aggregator/cadency-deputy/get-all/$cadency',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => DeputyResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<FullDeputyResponse> getDeputy(cadencyDeputyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FullDeputyResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options,
                    '/deputy-aggregator/cadency-deputy/$cadencyDeputyId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FullDeputyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeputyNounsResponse> getDeputyNouns(cadencyDeputyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeputyNounsResponse>(Options(
                method: 'GET', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options,
                '/deputy-aggregator/cadency-deputy/$cadencyDeputyId/noun-cloud',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeputyNounsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<void> putDeputies(cadency, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'PUT', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, '/user-aggregator/deputy-subscribe/$cadency',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  @override
  Future<List<SubscribedDeputyResponse>> getSubscribedDeputies(cadency) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<SubscribedDeputyResponse>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(
                    _dio.options, '/user-aggregator/deputy-subscribe/$cadency',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            SubscribedDeputyResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<void> deleteDeputy(cadency, cadencyDeputyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'DELETE', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options,
                '/user-aggregator/deputy-subscribe/$cadency/$cadencyDeputyId',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
