// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TimelineApi implements TimelineApi {
  _TimelineApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<MeetingsResponse> getMeetingsDates(cadency) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/user-aggregator/timeline/$cadency/parliament-meetings',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MeetingsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TimelineResponse> getAllDeputies(cadency, date) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    ArgumentError.checkNotNull(date, 'date');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/user-aggregator/timeline/$cadency/$date/v2',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TimelineResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<NounCloudResponse> getNounCloud(cadency, date) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    ArgumentError.checkNotNull(date, 'date');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/user-aggregator/timeline/$cadency/$date/noun-cloud',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = NounCloudResponse.fromJson(_result.data);
    return value;
  }
}
