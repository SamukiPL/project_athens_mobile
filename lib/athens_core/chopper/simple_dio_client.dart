import 'package:dio/dio.dart';

class SimpleDioClient {

  final Dio client;

  SimpleDioClient(this.client);

  void dispose() {
    client.close();
  }

}
