import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater_module.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/models/saved_notification.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_navigator.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/utils/life_cycle_manager/life_cycle_service.dart';
import 'package:project_athens/athens_core/utils/notifications_service.dart';
import 'package:project_athens/deputies_utils/injections/subscribed_deputy_cache_module.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:project_athens/main/injections/wakelock_module.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatelessWidget with RedirectionDelegate {
  @override
  Widget build(BuildContext context) {
    final firebaseMessages = Provider.of<FirebaseMessages>(context);
    NotificationsService.instance!.suspendedRedirectionStream.listen((SavedNotification notification) {
      switch (notification.type) {
        case "SPEECH":
          goToDestination(context, SpeechDetailsDestination(notification.refId!, false));
          break;
        // TODO: rewrite views to handle open destination just by id of requested element
        // case NotificationType.VOTE:
          // final partialVoteModel = VoteSlimModel(id: notification.refId, title: title, type: type, voteAt: voteAt, voteNumbers: voteNumbers, votingDesc: votingDesc)
          // goToDestination(_buildContext!, VoteDetailsDestination(_voteModel));
          // break;
        // case NotificationType.DEPUTY:
          // goToDestination(_buildContext!, DeputyDetailsDestination(_deputyModel))
      }
    });

    print('reintializing app from death! got a suspended redirection ');


    return ModuleWidget(
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
    );
  }
}
