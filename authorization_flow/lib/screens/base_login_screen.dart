import 'package:athens_core/injections/module.dart';
import 'package:athens_core/injections/module_widget.dart';
import 'package:authorization_flow/screens/base_login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseLoginScreen<BLOC extends BaseLoginBloc>
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
        providers: getProviders(context),
        child: Scaffold(
          body: Consumer<BLOC>(
            builder: (context, bloc, _) => _bodyBuilder(context, bloc),
          ),
        ));
  }

  List<Module> getProviders(BuildContext context);

  Widget _bodyBuilder(BuildContext context, BLOC bloc) {
    setupStreamListener(context, bloc);
    return generateBody(context, bloc);
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

  Widget generateBody(BuildContext context, BLOC bloc);

  void onSuccess(BuildContext context);

  void onAuthFailure();
}
