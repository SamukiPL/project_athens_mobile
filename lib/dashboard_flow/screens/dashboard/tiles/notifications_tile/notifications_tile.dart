import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile_bloc.dart';
import '../../../../../athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/dashboard_flow/navigation/dashboard_destinations.dart';
import 'package:provider/provider.dart';

class NotificationsTile extends SimpleTile {
  NotificationsTile() : super(
      textStyle: TextStyle(
          color: Colors.black87,
          fontSize: 25
      ),
      key: Key('tile_notifications'),
      bloc: SimpleTileBloc(),
      goTo: DashboardNotificationsScreenDestination()
  );

  final Stream<int> notificationsStream = NotificationsService.instance!
      .notificationsStream.map((event) => event.where((element) => !element.isRead).length);


  @override
  Widget build(BuildContext context) {
    return super.buildTile(
      context: context,
      tile: StreamProvider<int?>.value(
          initialData: null,
          value: notificationsStream,
          child: Consumer<int?>(
              builder: (context, count, _) => count == null
                  ? super.buildLoader()
                  : buildBadgeIcon(context, count)
          )
      ),
    );
  }

  Widget buildBadgeIcon(BuildContext context, int notificationsCount) {
    final theme = Theme.of(context);
    return Container(
      child: Center(
        child: Badge(
          badgeContent: Text(notificationsCount.toString(), style: TextStyle(color: Colors.white)),
          badgeColor: theme.primaryColor,
          child: Icon(
            Icons.notifications,
            color: SimpleTile.iconColor,
          ),
        ),
      ),
    );
  }
}