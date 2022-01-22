import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/labeled_checkbox.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends BaseScreen<BaseListBloc> {
  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  bool removeNotReadNotifications = false;

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
  Widget? buildFloatingActionButton(BuildContext context, BaseListBloc bloc) {
    return FloatingActionButton(
      onPressed: () async {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
                  ),
                  child: Wrap(
//                mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildBottomSheetContent(context, bloc),
                    ],
                  ));
            });
      },
      child: Icon(Icons.delete_forever),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildBottomSheetContent(BuildContext context, BaseListBloc bloc) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context, listen: false);

    return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                localizations.getText().dashboardNotificationsRemoveAllDialogTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
              child: Text(
                localizations.getText().dashboardNotificationsRemoveAllDialogContent(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
            LabeledCheckbox(
                value: removeNotReadNotifications,
                label: Text(
                  localizations.getText().dashboardNotificationsRemoveAllDialogRemoveNotRead(),
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
                onChange: (bool newValue) {
                  removeNotReadNotifications = newValue;
                }
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    localizations.getText().dashboardNotificationsRemoveAllDialogActionsNo(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                ),
                Expanded(child: Container()),
                FlatButton(
                    onPressed: () {
                      NotificationsService.instance!.erase(removeNotReadNotifications);
                      bloc.refresh();
                      Navigator.pop(context);
                    },
                    child: Text(
                      localizations.getText().dashboardNotificationsRemoveAllDialogActionsYes(),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor
                      ),
                    )
                )
              ],
            )
          ],
        )
    );
  }
}
