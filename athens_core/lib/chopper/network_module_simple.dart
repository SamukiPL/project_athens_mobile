import 'package:athens_core/chopper/error_interceptor.dart';
import 'package:athens_core/chopper/logging_interceptor.dart';
import 'package:athens_core/injections/module.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class NetworkModuleSimple extends Module {
  NetworkModuleSimple(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() => List<SingleChildWidget>.of([
        Provider<ChopperClient>(
          create: (_) => ChopperClient(
            baseUrl: "http://51.38.36.119:3505",
            converter: JsonConverter(),
            errorConverter: JsonConverter(),
            interceptors: [ErrorInterceptor(), LoggingInterceptor()],
          ),
          dispose: (context, client) => client.dispose(),
        )
      ]);
}
