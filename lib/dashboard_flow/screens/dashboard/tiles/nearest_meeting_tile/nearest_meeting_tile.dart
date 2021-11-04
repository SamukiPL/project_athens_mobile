import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile_bloc.dart';
import 'package:provider/provider.dart';

class NearestMeetingTile extends SimpleTile {
  final NearestMeetingTileBloc bloc;

  NearestMeetingTile(this.bloc) : super(text: "", key: Key('tile_nearest_meeting'));

  Widget _getMeetingText(BuildContext context) {
    return StreamProvider<String?>.value(
        value: bloc.nearestMeetingTextStream,
        initialData: null,
        child: Consumer<String?>(
          builder: (context, text, child) =>
            text == null
                ? super.buildLoader()
                : super.buildTextAndIcon(text: text, icon: Icons.calendar_today)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return super.buildTile(
      context: context,
      tile: _getMeetingText(context)
    );
  }
}