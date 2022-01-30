import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/utils/notifications/data/storage/saved_notification.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';

class NotificationManager extends StatefulWidget {
  NotificationManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _NotificationManagerState createState() => _NotificationManagerState();
}

class _NotificationManagerState extends State<NotificationManager> with WidgetsBindingObserver, RedirectionDelegate {
  late StreamSubscription<void> _suspendedNavigationSub;

  SavedNotification? _suspendedNavigation;

  @override
  void initState() {
    super.initState();

    _suspendedNavigationSub = NotificationsService
        .instance!
        .suspendedNavigationStream
        .listen((event) => _updateSuspendedNavigation());

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _updateSuspendedNavigation();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_suspendedNavigation != null) {
      switch (_suspendedNavigation!.type) {
        case "SPEECH":
          goToDestination(context, SpeechDetailsDestination(_suspendedNavigation!.refId!, false));
          break;
          // TODO: rewrite views to handle open destination just by id of requested element
          // case NotificationType.VOTE:
          // final partialVoteModel = VoteSlimModel(id: notification.refId, title: title, type: type, voteAt: voteAt, voteNumbers: voteNumbers, votingDesc: votingDesc)
          // goToDestination(_buildContext!, VoteDetailsDestination(_voteModel));
          // break;
          // case NotificationType.DEPUTY:
          // goToDestination(_buildContext!, DeputyDetailsDestination(_deputyModel))
      }
    }

    return widget.child;
  }

  void _updateSuspendedNavigation() {
    if (NotificationsService.instance!.hasSuspendedNavigation) {
      setState(() {
        _suspendedNavigation = NotificationsService.instance!.getSuspendedNavigation();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _suspendedNavigationSub.cancel();

    super.dispose();
  }
}