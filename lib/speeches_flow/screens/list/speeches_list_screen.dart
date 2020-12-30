import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speeches_list.dart';
import 'package:project_athens/speeches_flow/screens/list/speeches_list_bloc.dart';
import 'package:provider/provider.dart';

class SpeechesListScreen extends BaseScreen<SpeechesListBloc> {
  @override
  bool get showBackArrow => false;

  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.SPEECHES;

  @override
  String getAppBarTitle(AppLocalizations localizations, SpeechesListBloc bloc) {
    return localizations.getText().speechesSpeechesListTitle();
  }

  @override
  Widget buildBody(BuildContext context, SpeechesListBloc bloc) {
    final localizations = Provider.of<AppLocalizations>(context);

    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: DataLoadingWidget(
              bloc.dataLoadingBloc,
              child: _buildContent(bloc),
              noDataText: localizations.getText().speechesNoData(),
              onRetry: bloc.refresh,
            ),
          )
        ]
    );
  }

  Widget _buildContent(SpeechesListBloc bloc) => Container(
    height: 0,
    child: SpeechesList(bloc.adapter),
  );

  @override
  Widget buildAppBar(BuildContext context, SpeechesListBloc bloc) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    return SearchAppBar(title: getAppBarTitle(localizations, bloc), hintText: "Not ready yet", searchQuery: (query) {}, showBackArrow: showBackArrow);
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, SpeechesListBloc bloc) => null;

}