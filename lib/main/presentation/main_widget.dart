import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
      providers: [NetworkModule(context), LocalizationModule(context)],
      child: Consumer<BottomNavigationBloc>(
        builder: (context, bloc, _) => ChangeNotifierProvider<DestinationManager>.value(
          value: bloc.getDestinationManager(context),
          child: Consumer<DestinationManager>(
            builder: (context, manager, _) => WillPopScope(
              onWillPop: () async {
                return manager.goBack();
              },
              child: ModuleWidget(
                providers: manager.getScreenModules(context),
                child: manager.currentScreen()
              ),
            ),
          ),
        ),
      ),
    );
  }

}