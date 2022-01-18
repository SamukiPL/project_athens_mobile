import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/dashboard_flow/cache/parliament_meeting_cache.dart';
import 'package:project_athens/dashboard_flow/screens/nearest_meeting_screen/nearest_meeting_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DashboardNearestMeetingModule extends Module {
  final String _parliamentMeetingId;

  DashboardNearestMeetingModule(BuildContext context, this._parliamentMeetingId) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final ParliamentMeetingCache parliamentMeetingCache = Provider.of<ParliamentMeetingCache>(context);

    return [
      Provider<NearestMeetingBloc>(
          create: (context) => NearestMeetingBloc(parliamentMeetingCache, _parliamentMeetingId),
          dispose: (context, bloc) => bloc.dispose()
      ),
    ];
  }
}