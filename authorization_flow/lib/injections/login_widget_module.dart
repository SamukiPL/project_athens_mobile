import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:athens_core/chopper/network_module_simple.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:athens_core/injections/module.dart';

class LoginWidgetModule extends Module {
  LoginWidgetModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return List<SingleChildWidget>.of([
      ChangeNotifierProvider(
        create: (_) => LoginNavigationBloc(),
      )
    ]);
  }
}
