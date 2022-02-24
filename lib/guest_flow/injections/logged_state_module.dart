import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/guest_flow/domain/logged_state.dart';
import 'package:provider/provider.dart';

class LoggedStateModule extends Module {
  final LoggedState loggedState;

  LoggedStateModule(BuildContext context, this.loggedState) : super(context);

  @override
  List<SingleChildWidget> getProviders() => [
        Provider<LoggedState>.value(value: loggedState)
      ];
}
