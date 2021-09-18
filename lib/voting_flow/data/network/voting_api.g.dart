// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _VotingApi implements VotingApi {
  _VotingApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<VoteSearchResponse> getVoting(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-voting/9/search/v2',
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

  @override
  Future<VotingResponse> getVotingLiteById(voteId) async {
    ArgumentError.checkNotNull(voteId, 'voteId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-voting/9/id/$voteId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = VotingResponse.fromJson(_result.data);
    return value;
  }
}
