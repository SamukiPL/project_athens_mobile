import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/guest_flow/domain/logged_state.dart';
import 'package:provider/provider.dart';

class LoggedStateModule extends Module {
  final bool isLogged;

  LoggedStateModule(BuildContext context, this.isLogged) : super(context);

  @override
  List<SingleChildWidget> getProviders() => [
        Provider<LoggedState>(
            create: (_) => (isLogged)
                ? LoggedState.userLogged()
                : LoggedState.guestLogged())
      ];
}
