import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/timeline_flow/screens/group_details/group_details_bloc.dart';
import 'package:project_athens/timeline_flow/screens/group_details/group_details_list.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:provider/provider.dart';

class GroupDetailsScreen extends BaseScreen<GroupDetailsBloc> {

  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.TIMELINE;

  @override
  String getAppBarTitle(AppLocalizations localizations, GroupDetailsBloc bloc) {
    return localizations.getText().timelineTimelineNavTitle();
  }

  @override
  Widget buildBody(BuildContext context, GroupDetailsBloc bloc) {
    final destinationManager = Provider.of<DestinationManager>(context);

    return StreamProvider<VotingModel>.value(
      value: bloc.destination,
      updateShouldNotify: (_, current) => goToDestination(context, current, destinationManager),
      child: Consumer<VotingModel>(
        builder: (context, _, child) => child,
        child: DataLoadingWidget(
            bloc.dataLoadingBloc,
            child: _buildContent(bloc)
        ),
      ),
    );
  }

  Widget _buildContent(GroupDetailsBloc bloc) {
    return FutureProvider<List<TimelineRowViewModel>>.value(
      value: bloc.getListItems(),
      initialData: [],
      child: Consumer<List<TimelineRowViewModel>>(
        builder: (context, list, _) => GroupDetailsList(list),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, GroupDetailsBloc bloc) => null;

  bool goToDestination(BuildContext context, VotingModel model, DestinationManager destinationManager) {
    destinationManager.goToDestination(context, VoteDetailsDestination(currentBottomBarItem, model));
    return false;
  }

}