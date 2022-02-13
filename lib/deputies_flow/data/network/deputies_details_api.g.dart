// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputies_details_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _DeputiesDetailsApi implements DeputiesDetailsApi {
  _DeputiesDetailsApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<SpeechResponse>> getSpeechesByDeputy(
      cadencyDeputyId, query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query.toJson());
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<SpeechResponse>>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/deputy-aggregator/cadency-speech/deputy/${cadencyDeputyId}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => SpeechResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<VotingResponse>> getVotesByDeputy(cadencyDeputyId, query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query.toJson());
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<VotingResponse>>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/deputy-aggregator/cadency-voting/deputy/${cadencyDeputyId}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => VotingResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<DeputyVoteAccuracyResponse> getDeputyVoteAccuracy(
      cadencyDeputyId, parliamentClubId, accuracyType, query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        DeputyVoteAccuracyResponse>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/deputy-aggregator/cadency-deputy/${cadencyDeputyId}/vote-accuracy/${parliamentClubId}/${accuracyType}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeputyVoteAccuracyResponse.fromJson(_result.data!);
    return value;
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
