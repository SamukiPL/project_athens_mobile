// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputies_details_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeputiesDetailsApi implements DeputiesDetailsApi {
  _DeputiesDetailsApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<SpeechResponse>> getSpeechesByDeputy(
      cadencyDeputyId, query) async {
    ArgumentError.checkNotNull(cadencyDeputyId, 'cadencyDeputyId');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = query;
    final _result = await _dio.request<List<dynamic>>(
        '/deputy-aggregator/cadency-speech/deputy/$cadencyDeputyId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => SpeechResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<VotingResponse>> getVotesByDeputy(
      cadency, cadencyDeputyId, query) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    ArgumentError.checkNotNull(cadencyDeputyId, 'cadencyDeputyId');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = query;
    final _result = await _dio.request<List<dynamic>>(
        '/deputy-aggregator/cadency-voting/$cadency/deputy/$cadencyDeputyId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => VotingResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
