import 'dart:async';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/button_loader/button_loader.dart';
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
        child: StreamProvider<bool>.value(
          value: bloc.hasAnyConnection,
          initialData: true,
          child: Consumer<bool>(builder: (context, isConnected, child) {
            if (isConnected) {
              return CircularProgressIndicator(
                backgroundColor: theme.primaryColor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              );
            } else {
              return _buildNoConnection(context, bloc);
            }
          }),
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
          navigation.goToMainWidget(context,
              loggedState: LoggedState.guestLogged());
          break;
        case SplashDirection.LOGIN:
          navigation.goToLoginWidget(context);
          break;
      }
      subscription.cancel();
    });
  }

  Widget _buildNoConnection(BuildContext context, SplashScreenBloc bloc) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = Provider.of<AppLocalizations>(context);

    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.explore_off_outlined,
                color: Colors.white.withOpacity(0.5), size: 50),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: Text(
                l10n.getText().universalNoConnectionTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: theme.primaryTextTheme.bodyLarge?.fontSize ?? 18),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  l10n.getText().universalNoConnectionDescription(),
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize:
                          theme.primaryTextTheme.bodySmall?.fontSize ?? 14),
                )),
            Container(
                margin: EdgeInsets.only(top: 8),
                child: ElevatedButton(
                  child: Text(
                    l10n.getText().universalRefresh().toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(),
                  onPressed: () => bloc.checkConnection(),
                ))
          ]),
    );
  }
}
