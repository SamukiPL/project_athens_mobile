import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:provider/provider.dart';

class AutoUpdaterModule extends Module {
  AutoUpdaterModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<AutoUpdater>(
        create: (context) => AutoUpdater(),
        dispose: (context, autoUpdater) => autoUpdater.dispose(),
        lazy: false,
      ),
    ];
  }
}
