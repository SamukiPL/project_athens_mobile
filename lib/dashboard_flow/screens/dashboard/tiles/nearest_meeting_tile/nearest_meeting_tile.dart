import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile_bloc.dart';
import 'package:provider/provider.dart';

class NearestMeetingTile extends SimpleTile {
  @override
  final NearestMeetingTileBloc bloc;

  NearestMeetingTile(this.bloc) : super(
      key: Key('tile_nearest_meeting'),
      bloc: bloc,
      // TODO: API needs to be patched in order to properly show agenda points.
      // goToFn: DashboardNearestMeetingScreenDestination(bloc.nearestParliamentMeetingId!)
  );

  @override
  Widget buildTileContent(BuildContext context) {
    return StreamProvider<String?>.value(
        value: bloc.nearestMeetingTextStream,
        initialData: null,
        child: Consumer<String?>(
          builder: (context, text, child) =>
            text == null
                ? buildLoader()
                : buildTextAndIcon(text: text, icon: Icons.calendar_today)
        )
    );
  }
}