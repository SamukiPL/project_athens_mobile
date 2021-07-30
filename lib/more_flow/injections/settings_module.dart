import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/more_flow/screens/settings/settings_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SettingsModule extends Module {
  SettingsModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<SettingsBloc>(
        create: (_) => SettingsBloc(),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }
}
