import 'package:athens_core/i18n/localization.dart';
import 'package:athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class LocalizationModule extends Module {
  LocalizationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    AppLocalizations localization = AppLocalizations.of(context);
    return [Provider<AppLocalizations>.value(value: localization)];
  }
}
