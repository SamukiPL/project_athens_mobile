import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseLoginScreen<BLOC extends BaseBloc> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
        providers: getProviders(context),
        child: Consumer<BLOC>(
          builder: (context, bloc, _) => Scaffold(
            appBar: generateAppBar(context, bloc),
            body: bodyBuilder(context, bloc),
            floatingActionButton: generateFab(context, bloc),
          ),
        ));
  }

  List<Module> getProviders(BuildContext context);

  @protected
  Widget bodyBuilder(BuildContext context, BLOC bloc) {
    setupStreamListener(context, bloc);
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(0),
        child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: generateBody(context, bloc)));
  }

  void setupStreamListener(BuildContext context, BLOC bloc) {
    bloc.state.listen((state) {
      switch (state) {
        case ScreenState.SUCCESS:
          onSuccess(context);
          break;
        case ScreenState.AUTH_FAILURE:
          onAuthFailure();
          break;
        case ScreenState.NETWORK_FAILURE:
          Scaffold.of(context).showBottomSheet((context) => GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 300,
                  color: Colors.red,
                ),
              ));
          break;
      }
    });
  }

  Widget generateAppBar(BuildContext context, BLOC bloc);

  Widget generateBody(BuildContext context, BLOC bloc);

  Widget generateFab(BuildContext context, BLOC bloc);

  void onSuccess(BuildContext context);

  void onAuthFailure();
}
