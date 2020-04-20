import 'package:athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/navigation/main_widget_navigation.dart';
import 'package:provider/provider.dart';

class MainWidgetModule extends Module {
  MainWidgetModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(
        create: (_) => MainWidgetNavigation(),
      )
    ];
  }
}
