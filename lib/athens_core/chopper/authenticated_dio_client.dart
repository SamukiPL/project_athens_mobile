import 'package:dio/dio.dart';

class AuthenticatedDioClient {
  final Dio client;

  AuthenticatedDioClient(this.client);

  dispose() {
    client.close();
  }
}
