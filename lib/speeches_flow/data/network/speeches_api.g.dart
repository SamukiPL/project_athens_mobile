// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speeches_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SpeechesApi implements SpeechesApi {
  _SpeechesApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<SpeechResponse> getSpeech(speechId) async {
    ArgumentError.checkNotNull(speechId, 'speechId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-speech/$speechId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SpeechResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SpeechesSearchResponse> getSpeeches(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-speech/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SpeechesSearchResponse.fromJson(_result.data);
    return value;
  }
}
