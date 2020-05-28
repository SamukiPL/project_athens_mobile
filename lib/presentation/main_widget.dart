import 'package:athens_core/chopper/network_module.dart';
import 'package:athens_core/injections/module_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/injections/main_widget_module.dart';
import 'package:provider/provider.dart';
import 'package:athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/navigation/bottom_navigation_bloc_impl.dart';

class MainWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
      providers: [NetworkModule(context), MainWidgetModule(context)],
      child: Consumer<BottomNavigationBloc>(
        builder: (context, bloc, _) => bloc.currentItem.getDestinationManager().currentScreen(),
      ),
    );
  }

}