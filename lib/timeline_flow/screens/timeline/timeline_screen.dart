import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/backdrop/backdrop_widget.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_picker_dialog_custom.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_utils.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_bloc.dart';
import 'package:provider/provider.dart';

class TimelineScreen extends BaseScreen<TimelineBloc> {

  @override
  bool get showBackArrow => false;
  @override
  bool get shouldShowBottomBar => true;

  @override
  Widget buildAppBar(BuildContext context, TimelineBloc bloc) {
    return CalendarAppBar(bloc.calendarBloc,
            () => { bloc.setPreviousDate() },
            () => { bloc.setNextDate() });
  }

  @override
  Widget buildBody(BuildContext context, TimelineBloc bloc) {
    final localizations = Provider.of<AppLocalizations>(context);

    return Container(
      color: Theme.of(context).primaryColor,
      child: BackdropWidget(
        bottomChild: NounCloud(bloc: bloc.nounCloudBloc),
        topChild: DataLoadingWidget(
          bloc.dataLoadingBloc,
          child: PagingList(bloc.adapter, refreshable: true,),
          noDataText: localizations.getText().timelineNoEvents(),
          onRetry: bloc.refresh,
        ),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, TimelineBloc bloc) {
    return FloatingActionButton(
      onPressed: () async {
        final picked = await showCustomDatePicker(
            context: context,
            initialDate: bloc.selectedDate,
            firstDate: DateTime.utc(2016),
            lastDate: DateTime.utc(2024),
            selectableDayPredicate: (DateTime date) {
              return bloc.dates.any((element) => dateOnly(element.meetingDate).isAtSameMomentAs(date));
            },
        );
        if (picked != null)
          bloc.loadNewDate(picked);
      },
      child: Icon(Icons.calendar_today),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
