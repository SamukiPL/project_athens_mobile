import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/guest_flow/screens/guest_blockade_bloc.dart';
import 'package:provider/provider.dart';

class GuestBlockadeScreen extends BaseScreen<GuestBlockadeBloc> {
  @override
  Widget buildBody(BuildContext context, GuestBlockadeBloc bloc) {
    final localization = Provider.of<AppLocalizations>(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 32),
              child: Icon(Icons.sentiment_dissatisfied, size: 100, color: theme.primaryColor,),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              child: Text(
                "Treść dostępna po zalogowaniu",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            MaterialButton(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Przejdź do logowania",
                  style: TextStyle(color: Colors.white),
                  textScaleFactor: 1.5,
                ),
              ),
              onPressed: (() {
                bloc.clearTokens();
                final appNavigation = Provider.of<AppNavigation>(context, listen: false);
                appNavigation.goToLoginWidget(context);
              }),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            )
          ],
        ));
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, GuestBlockadeBloc bloc) => null;

  @override
  Widget? buildAppBar(BuildContext context, GuestBlockadeBloc bloc) => null;

  @override
  bool get shouldShowBottomBar => true;

  @override
  bool get showBackArrow => false;
}