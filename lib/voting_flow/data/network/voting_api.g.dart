// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _VotingApi implements VotingApi {
  _VotingApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<VoteSearchResponse> getVoting(request) async {
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-voting/9/search',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = VoteSearchResponse.fromJson(_result.data);
    return value;
  }
}
