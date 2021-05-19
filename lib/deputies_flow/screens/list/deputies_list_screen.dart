import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:provider/provider.dart';

class DeputiesListScreen extends BaseScreen<BaseListBloc> {

  @override
  bool get showBackArrow => false;
  @override
  bool get shouldShowBottomBar => true;

  @override
  String getAppBarTitle(AppLocalizations localizations, BaseListBloc bloc) {
    return localizations.getText().deputiesDeputiesListTitle();
  }

  @override
  Widget buildBody(BuildContext context, BaseListBloc bloc) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 0,
              child: PagingList(bloc.adapter, paginationIncluded: false,),
            ),
          )
        ]
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, BaseListBloc bloc) => null;

  @override
  Widget buildAppBar(BuildContext context, BaseListBloc bloc) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    return SearchAppBar(title: getAppBarTitle(localizations, bloc), hintText: getAppBarTitle(localizations, bloc), searchQuery: (query) {}, showBackArrow: showBackArrow);
  }

}