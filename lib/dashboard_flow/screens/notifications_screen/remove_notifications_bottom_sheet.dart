import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/labeled_checkbox.dart';
import 'package:provider/provider.dart';

class RemoveNotificationsBottomSheet extends StatefulWidget {
  /// returns whether list should be refreshed or not.
  final Function(bool shouldRefresh) onClose;

  RemoveNotificationsBottomSheet({required this.onClose});

  @override
  _RemoveNotificationsBottomSheetState createState() =>
      _RemoveNotificationsBottomSheetState(this.onClose);
}

class _RemoveNotificationsBottomSheetState extends State<RemoveNotificationsBottomSheet> {
  final Function(bool shouldRefresh) onClose;

  _RemoveNotificationsBottomSheetState(this.onClose);

  bool removeNotReadNotifications = false;

  @override
  Widget build(BuildContext context) {

    return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
        ),
        child: Wrap(
          children: <Widget>[
            _buildBottomSheetContent(context)
          ],
        )
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    final AppLocalizations l10n = Provider.of<AppLocalizations>(context, listen: false);

    return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                l10n.getText().dashboardNotificationsRemoveAllDialogTitle(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 8, left: 16, right: 16),
              child: Text(
                l10n.getText().dashboardNotificationsRemoveAllDialogContent(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
            LabeledCheckbox(
                value: removeNotReadNotifications,
                label: Text(
                  l10n.getText().dashboardNotificationsRemoveAllDialogRemoveNotRead(),
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
                    l10n.getText().dashboardNotificationsRemoveAllDialogActionsNo(),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                  ),
                ),
                Expanded(child: Container()),
                FlatButton(
                    onPressed: () {
                      NotificationsService.instance!.erase(removeNotReadNotifications);
                      onClose(true);
                      Navigator.pop(context);
                    },
                    child: Text(
                      l10n.getText().dashboardNotificationsRemoveAllDialogActionsYes(),
                      style: TextStyle(
                          color: Theme.of (context).primaryColor
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
