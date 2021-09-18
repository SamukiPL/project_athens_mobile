// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputies_details_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeputiesDetailsApi implements DeputiesDetailsApi {
  _DeputiesDetailsApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<SpeechResponse>> getSpeechesByDeputy(
      cadencyDeputyId, query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query.toJson());
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<SpeechResponse>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options,
                    '/deputy-aggregator/cadency-speech/deputy/$cadencyDeputyId',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => SpeechResponse.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<VotingResponse>> getVotesByDeputy(
      cadency, cadencyDeputyId, query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query.toJson());
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<
        List<VotingResponse>>(Options(
            method: 'POST', headers: <String, dynamic>{}, extra: _extra)
        .compose(_dio.options,
            '/deputy-aggregator/cadency-voting/$cadency/deputy/$cadencyDeputyId',
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
    ArgumentError.checkNotNull(cadencyDeputyId, 'cadencyDeputyId');
    ArgumentError.checkNotNull(parliamentClubId, 'parliamentClubId');
    ArgumentError.checkNotNull(accuracyType, 'accuracyType');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(query?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-deputy/$cadencyDeputyId/vote-accuracy/$parliamentClubId/$accuracyType',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = DeputyVoteAccuracyResponse.fromJson(_result.data);
    return value;
  }
}
