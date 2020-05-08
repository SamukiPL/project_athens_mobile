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
  List<SingleChildWidget> getProviders() {
    final client = ChopperClient(
      baseUrl: "http://51.38.36.119:3505",
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [ErrorInterceptor(), LoggingInterceptor()],
    );
    return List<SingleChildWidget>.of([
      Provider<SimpleChopperClient>(
        create: (_) => SimpleChopperClient(client),
        dispose: (context, client) => client.dispose(),
      )
    ]);
  }
}

class SimpleChopperClient {

  final ChopperClient client;

  SimpleChopperClient(this.client);

  void dispose() {
    client.dispose();
  }

}
