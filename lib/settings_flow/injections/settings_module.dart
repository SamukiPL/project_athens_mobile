import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_bloc.dart';
import 'package:provider/provider.dart';

class SettingsModule extends Module {
  SettingsModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<SettingsBloc>(
        create: (_) => SettingsBloc(),
        dispose: (context, bloc) {
          bloc.dispose();
        },
      )
    ];
  }

}