import 'package:athens_core/injections/module.dart';
import 'package:athens_core/injections/module_widget.dart';
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
        child: Scaffold(
          appBar: buildAppBar(context),
          body: Consumer<BLOC>(
            builder: (context, bloc, _) => buildBody(context, bloc),
          ),
        ));
  }

  Widget buildBody(BuildContext context, BLOC bloc);
  
  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: showBackArrow,
        child: BackButton(),
      ),
      title: Text(appBarTitle),
    );
  }

}