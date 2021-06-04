import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/configuration.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class WakelockModule extends Module {
  WakelockModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider.value(value: WakelockService(
          Provider.of<Configuration>(context),
          Provider.of<BottomNavigationBloc>(context)),
      )
    ];
  }
}