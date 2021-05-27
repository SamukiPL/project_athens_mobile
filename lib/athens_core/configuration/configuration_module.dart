import 'package:project_athens/athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'configuration.dart';

class ConfigurationModule extends Module {
  ConfigurationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<Configuration>(
        create: (context) => Configuration(),
        dispose: (context, configuration) => configuration.dispose(),
      ),
    ];
  }
}
