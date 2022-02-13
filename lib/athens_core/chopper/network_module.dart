import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/chopper/authenticated_dio_client.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class NetworkModule extends Module {
  NetworkModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final Dio dio = Provider.of<AuthenticatedDioClient>(context).client;

    return [
      Provider<Dio>.value(
        value: dio,
      )
    ];
  }
}
