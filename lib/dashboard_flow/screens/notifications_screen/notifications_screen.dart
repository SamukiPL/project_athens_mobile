import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/saved_notification.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/pagination/paging_list.dart';

class NotificationsScreen extends BaseScreen<BaseListBloc> {
  NotificationsScreen();

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  @override
  String getAppBarTitle(AppLocalizations localizations, BaseListBloc bloc) {
    return localizations.getText().dashboardNotificationsTitle();
  }

  @override
  Widget buildBody(BuildContext context, BaseListBloc bloc) {
    final ThemeData theme = Theme.of(context);
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EasyFiltersList(),
          Expanded(
            child: Container(
              height: 0,
              child: PagingList(
                bloc.adapter,
                paginationIncluded: false,
                separator: Container(
                  color: theme.dividerColor,
                  width: double.infinity,
                  height: 1,
                ),
              ),
            ),
          )
        ]
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, BaseListBloc bloc) => null;
}