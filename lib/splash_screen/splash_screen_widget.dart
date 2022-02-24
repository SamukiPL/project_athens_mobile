import 'dart:async';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/guest_flow/domain/logged_state.dart';
import 'package:provider/provider.dart';
import 'splash_screen_bloc.dart';
import 'splash_screen_module.dart';

class SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
      providers: [SplashScreenModule(context)],
      child: Consumer<SplashScreenBloc>(
        builder: (context, bloc, _) => _generateBody(context, bloc),
      ),
    );
  }

  Widget _generateBody(BuildContext context, SplashScreenBloc bloc) {
    final theme = Theme.of(context);

    startListening(context, bloc);
    return Container(
      color: theme.primaryColor,
      child: Center(
        widthFactor: 25,
        heightFactor: 25,
        child: CircularProgressIndicator(
          backgroundColor: theme.primaryColor,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  void startListening(BuildContext context, SplashScreenBloc bloc) {
    bloc.checkDirection();
    var navigation = Provider.of<AppNavigation>(context);

    late StreamSubscription subscription;
    subscription = bloc.direction.listen((direction) {
      switch (direction) {
        case SplashDirection.MAIN:
          navigation.goToMainWidget(context);
          break;
        case SplashDirection.MAIN_GUEST:
          navigation.goToMainWidget(context, loggedState: LoggedState.guestLogged());
          break;
        case SplashDirection.LOGIN:
          navigation.goToLoginWidget(context);
          break;
      }
      subscription.cancel();
    });
  }
}
