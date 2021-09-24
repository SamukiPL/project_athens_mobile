import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/filters_and_sort/filters_bottom_sheet.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:provider/provider.dart';

class SpeechesListScreen extends BaseScreen<BaseListBloc> {
  @override
  bool get showBackArrow => false;
  @override
  bool get shouldShowBottomBar => true;

  @override
  String getAppBarTitle(AppLocalizations localizations, BaseListBloc bloc) {
    return localizations.getText().speechesSpeechesListTitle();
  }

  @override
  Widget buildBody(BuildContext context, BaseListBloc bloc) {
    final localizations = Provider.of<AppLocalizations>(context);

    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
        child: BaseListWidget(
          listBloc: bloc,
          noDataText: localizations.getText().speechesNoData(),
          separator: Divider(
            height: 1,
            indent: 48,
          ),
        ),
      )
    ]);
  }

  @override
  Widget buildAppBar(BuildContext context, BaseListBloc bloc) {
    final AppLocalizations localizations =
        Provider.of<AppLocalizations>(context);

    return SearchAppBar(
        title: getAppBarTitle(localizations, bloc),
        hintText: localizations.getText().filtersFiltersSearchPhrase(),
        searchQuery: (query) {},
        showBackArrow: showBackArrow,
        additionalIcons: [
          IconButton(
              icon: Icon(
                Icons.filter_alt_sharp,
                color: Colors.white,
              ),
              onPressed: () => showFullScreenDialog(context))
        ]);
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, BaseListBloc bloc) =>
      null;

  void showFullScreenDialog(BuildContext context) {
    showFilterBottomSheet(context);
  }
}
