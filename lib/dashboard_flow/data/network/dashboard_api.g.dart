// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _DashboardApi implements DashboardApi {
  _DashboardApi(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<DashboardResponse> getDashboard(
      cadence,
      meeting,
      voteAbsent,
      monthMeetings,
      speechesCounter,
      speechesCounterPerYear,
      voteAbsentPerYear) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'meeting': meeting,
      r'voteAbsent': voteAbsent,
      r'monthMeetings': monthMeetings,
      r'speechesCounter': speechesCounter,
      r'speechesCounterPerYear': speechesCounterPerYear,
      r'voteAbsentPerYear': voteAbsentPerYear
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DashboardResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/user-aggregator/dashboard/${cadence}/',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DashboardResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ParliamentMeetingDetailsResponse> getParliamentMeetingDetails(
      cadence, parliamentMeetingId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        ParliamentMeetingDetailsResponse>(Options(
            method: 'GET', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/user-aggregator/timeline/${cadence}/parliament-meetings/${parliamentMeetingId}',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ParliamentMeetingDetailsResponse.fromJson(_result.data!);
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
