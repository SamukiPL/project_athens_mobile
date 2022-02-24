import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration_manager.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration_manager_bloc.dart';
import 'package:project_athens/athens_core/injections/item_was_seen/item_was_seen_module.dart';
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
  final bool isLogged;

  const MainWidget({Key? key, this.isLogged = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseMessages = Provider.of<FirebaseMessages>(context);
    final RemoteConfiguration config = Provider.of<RemoteConfiguration>(context);
    final RemoteConfigurationManagerBloc bloc = RemoteConfigurationManagerBloc(config);

    return RemoteConfigurationManager(
        bloc: bloc,
        child: NotificationManager(
          child: ModuleWidget(
            providers: [
              SubscribedDeputyCacheModule(context, firebaseMessages),
              WakelockModule(context),
              ItemWasSeenModule(context)
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
                    DestinationNavigator(item, item.getInitialDestination(isLogged)))
                    .toList(),
              ),
            ),
          )
        )
    );
  }
}
