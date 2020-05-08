import 'package:athens_core/chopper/network_module_simple.dart';
import 'package:authorization_flow/data/network/login_api.dart';
import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';

import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:athens_core/injections/module.dart';

class LoginWidgetModule extends Module {
  LoginWidgetModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = Provider.of<SimpleChopperClient>(context);

    return List<SingleChildWidget>.of([
      ChangeNotifierProvider(
        create: (_) => LoginNavigationBloc(),
      ),
      Provider<LoginApi>(
        create: (_) => LoginApi.create(client.client),
        dispose: (_, api) => api.dispose(),
      )
    ]);
  }
}
