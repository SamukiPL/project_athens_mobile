import 'package:dio/dio.dart';

class AgreementHtmlApi {
  final Dio _dio;

  AgreementHtmlApi(this._dio);

  Future<Response<String>> getAgreementHtml(String url) {
    return _dio.get(
      url,
      options: Options(
        contentType: 'text/html'
      )
    );
  }
}