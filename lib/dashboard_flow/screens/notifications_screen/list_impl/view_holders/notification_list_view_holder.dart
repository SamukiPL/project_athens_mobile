import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/list_impl/notification_list_item_view_model.dart';
import 'package:provider/provider.dart';

class NotificationListViewHolder extends StatelessWidget
    with RedirectionDelegate {
  final NotificationListItemViewModel viewModel;

  const NotificationListViewHolder({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<NotificationListItemViewModel>(
            builder: (context, viewModel, _) => GestureDetector(
                  onTap: () {
                    NotificationsService.instance
                        ?.openDestinationFromNotification(viewModel.model);
                    viewModel.model.isRead = true;
                    viewModel.notifyListeners();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getTitleAndDateRow(theme, viewModel),
                      _getDescriptionRow(theme, viewModel),
                      TechnicalData(technicalId: viewModel.model.messageId!),
                    ],
                  ),
                )));
  }

  Widget _getTitleAndDateRow(
      ThemeData theme, NotificationListItemViewModel viewModel) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            viewModel.model.title != null ? viewModel.model.title : "",
            style: TextStyle(
                color: viewModel.model.isRead
                    ? theme.dividerColor
                    : theme.primaryColor,
                fontSize: 14,
                fontWeight: viewModel.model.isRead
                    ? FontWeight.normal
                    : FontWeight.bold),
          ),
          Text(
            DateFormat("HH:mm dd.MM.y", "pl").format(viewModel.model.sentTime),
            style: TextStyle(color: theme.dividerColor, fontSize: 10),
          )
        ],
      ),
    );
  }

  Widget _getDescriptionRow(
      ThemeData theme, NotificationListItemViewModel viewModel) {
    return Container(
        margin: EdgeInsets.only(top: 4, bottom: 4),
        child: Text(
          viewModel.model.body!,
          style: TextStyle(color: theme.dividerColor, fontSize: 12),
        ));
  }
}
