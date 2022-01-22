import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater_module.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_navigator.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/deputies_utils/injections/subscribed_deputy_cache_module.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:project_athens/main/injections/wakelock_module.dart';
import 'package:project_athens/main/presentation/notifications_manager.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget with RedirectionDelegate {
  @override
  Widget build(BuildContext context) {
    final firebaseMessages = Provider.of<FirebaseMessages>(context);

    return NotificationManager(
      child: ModuleWidget(
        providers: [
          NetworkModule(context),
          LocalizationModule(context),
          SubscribedDeputyCacheModule(context, firebaseMessages),
          WakelockModule(context),
          AutoUpdaterModule(context)
        ],
        child: Consumer<BottomNavigationBloc>(
          builder: (context, bloc, child) => WillPopScope(
              child: child!,
              onWillPop: () async {
                bloc.pop();
                return false;
              }),
          child: Stack(
            children: BottomNavItem.values
                .map((item) =>
                DestinationNavigator(item, item.getInitialDestination()))
                .toList(),
          ),
        ),
      )
    );
  }
}
