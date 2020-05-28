import 'package:athens_core/injections/module.dart';
import 'package:athens_core/injections/module_widget.dart';
import 'package:athens_core/navigation/bottom_navigation_widget.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseScreen<BLOC extends BaseBloc> extends StatelessWidget {

  String get appBarTitle;
  bool get showBackArrow;

  List<Module> getProviders(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
        providers: getProviders(context),
        child: Consumer<BLOC>(
        builder: (context, bloc, _) => Scaffold(
            appBar: buildAppBar(context, bloc),
            body: buildBody(context, bloc),
            floatingActionButton: buildFloatingActionButton(context, bloc),
            bottomNavigationBar: BottomNavigationWidget(),
          ),
        ));
  }

  @protected
  Widget buildBody(BuildContext context, BLOC bloc);

  @protected
  Widget buildAppBar(BuildContext context, BLOC bloc) {
    return AppBar(
      leading: Visibility(
        visible: showBackArrow,
        child: BackButton(),
      ),
      title: Text(appBarTitle),
    );
  }

  @protected
  Widget buildFloatingActionButton(BuildContext context, BLOC bloc);

}