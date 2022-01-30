import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/athens_core/presentation/db_source/db_source.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';
import 'package:project_athens/dashboard_flow/screens/nearest_meeting_screen/nearest_meeting_bloc.dart';
import 'package:provider/provider.dart';
import 'parliament_meeting_agenda_point_extension.dart';

class NearestMeetingScreen extends BaseScreen<NearestMeetingBloc> {
  final String parliamentMeetingId;

  NearestMeetingScreen(this.parliamentMeetingId);

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  @override
  String getAppBarTitle(AppLocalizations localizations, NearestMeetingBloc bloc) {
    return localizations.getText().dashboardNearestMeetingTitle();
  }

  @override
  Widget buildBody(BuildContext context, NearestMeetingBloc bloc) {
    final ThemeData theme = Theme.of(context);

    final AppLocalizations _localizations = Provider.of<AppLocalizations>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: DataLoadingWidget(
        bloc.dataLoadingBloc,
        child: _getChild(bloc, theme, _localizations)
      ),
    );
  }

  Widget _getChild(NearestMeetingBloc bloc, ThemeData theme, AppLocalizations _localizations) {
      return Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle(bloc.meetingModel, theme, _localizations),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: _getAgendaPoints(bloc.meetingModel, theme, _localizations)
                      )
                  )
              ),
              TechnicalData(technicalId: bloc.meetingModel.id),
              DbSource(bloc.meetingModel)
            ]
        )
      );
  }

  Widget _getTitle(ParliamentMeetingModel model, ThemeData theme, AppLocalizations _localizations) {
    final String? sessionIIdStr = model.sessionIId != null
        ? "${model.sessionIId}. ${_localizations.getText().dashboardNearestMeetingParliamentMeeting()}"
        : null;

    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              DateFormat("dd MMMM y", "pl").format(model.date),
              style: TextStyle(
                  fontSize: 30,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w300
              ),
            ),
            sessionIIdStr != null ? Text(
              sessionIIdStr.toUpperCase(),
              style: theme.textTheme.overline?.copyWith(
                  color: theme.dividerColor,
                  fontSize: 14
              ),
            ) : Container()
          ],
        )
      )
    );
  }

  List<Widget> _getAgendaPoints(ParliamentMeetingModel model, ThemeData theme, AppLocalizations _localizations) {
    return [
      _getAgendaPointsSegment(
          model.agenda.agendaPoints.plannedPoints,
          _localizations.getText().dashboardNearestMeetingAgenda(),
          theme
      ),
      _getAgendaPointsSegment(
          model.agenda.agendaPoints.notPlannedPoints,
          _localizations.getText().dashboardNearestMeetingSupplementingAgenda(),
          theme
      ),
      _getAgendaPointsSegment(
          model.agenda.agendaPoints.toBeSettledPoints,
          _localizations.getText().dashboardNearestMeetingToBeSettled(),
          theme
      )
    ];
  }

  Widget _getAgendaPointsSegment(List<ParliamentMeetingAgendaPoint> points, String title, ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold
              )
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: points.map((point) => _getAgendaPoint(point, theme)).toList(),
              ),
            ),
          )
        ]
      ),
    );
  }

  Widget _getAgendaPoint(ParliamentMeetingAgendaPoint point, ThemeData theme) {
    final String orderPoint = point.orderPointToString;

    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
                text: "",
                style: theme.textTheme.bodyText2,
                children: <TextSpan>[
                  TextSpan(text: orderPoint, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: point.agenda, style: TextStyle())
                ]
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            width: double.infinity,
            height: 1,
            color: theme.dividerColor.withOpacity(0.4),
          )
        ],
      )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, NearestMeetingBloc bloc) => null;
}