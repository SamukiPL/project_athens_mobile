import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/chopper/simple_dio_client.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:provider/provider.dart';

class LoginWidgetModule extends Module {
  LoginWidgetModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = Provider.of<SimpleDioClient>(context);

    return List<SingleChildWidget>.of([
      ChangeNotifierProvider(
        create: (_) => LoginNavigationBloc(),
      ),
      Provider<LoginApi>(
        create: (_) => LoginApi(client.client),
      )
    ]);
  }
}
