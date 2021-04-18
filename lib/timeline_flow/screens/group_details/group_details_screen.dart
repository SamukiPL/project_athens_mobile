import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/timeline_flow/screens/group_details/group_details_bloc.dart';
import 'package:project_athens/timeline_flow/screens/group_details/group_details_list.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:provider/provider.dart';

class GroupDetailsScreen extends BaseScreen<GroupDetailsBloc> {

  @override
  String getAppBarTitle(AppLocalizations localizations, GroupDetailsBloc bloc) {
    return localizations.getText().timelineTimelineNavTitle();
  }

  @override
  Widget buildBody(BuildContext context, GroupDetailsBloc bloc) {
    return DataLoadingWidget(
      bloc.dataLoadingBloc,
      child: _buildContent(bloc),
      onRetry: () => {},
    );
  }

  Widget _buildContent(GroupDetailsBloc bloc) {
    return FutureProvider<List<BaseItemViewModel>>.value(
      value: bloc.getListItems(),
      initialData: [],
      child: Consumer<List<BaseItemViewModel>>(
        builder: (context, list, _) => GroupDetailsList(list),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, GroupDetailsBloc bloc) => null;

}