import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/full_card/full_card.dart';
import 'package:project_athens/dashboard_flow/screens/nearest_meeting_screen/nearest_meeting_bloc.dart';

class NearestMeetingScreen extends BaseScreen<NearestMeetingBloc> {
  NearestMeetingScreen();

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  @override
  String getAppBarTitle(AppLocalizations localizations, NearestMeetingBloc bloc) {
    return localizations.getText().dashboardTitle();
  }

  @override
  Widget buildBody(BuildContext context, NearestMeetingBloc bloc) {
    return Container(
      child: Column(
        children: [
          FullCard(
            
            child: Container(),
          )
        ],
      )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, NearestMeetingBloc bloc) => null;
}