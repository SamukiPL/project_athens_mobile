import 'package:project_athens/athens_core/auto_updater/auto_updater.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class AutoUpdaterModule extends Module {
  AutoUpdaterModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<AutoUpdater>(
        create: (context) {
          final RemoteConfiguration _config = Provider.of<RemoteConfiguration>(context, listen: false);
          final AppLocalizations _localizations = Provider.of<AppLocalizations>(context, listen: false);
          final AutoUpdater _autoUpdater = AutoUpdater(_config, _localizations);
          _autoUpdater.checkForUpdates();

          return _autoUpdater;
        },
        dispose: (context, autoUpdater) => autoUpdater.dispose(),
        lazy: false,
      ),
    ];
  }
}
