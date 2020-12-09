// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parliament_clubs_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ParliamentClubsApi implements ParliamentClubsApi {
  _ParliamentClubsApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ParliamentClubResponse> geParliamentClubs(cadency) async {
    ArgumentError.checkNotNull(cadency, 'cadency');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/deputy-aggregator/cadency-parliament-club/$cadency',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ParliamentClubResponse.fromJson(_result.data);
    return value;
  }
}
