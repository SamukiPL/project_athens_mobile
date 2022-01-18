import 'package:project_athens/athens_core/models/saved_notification.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/list_impl/view_holders/notification_list_view_holder.dart';
import 'package:flutter/cupertino.dart';

class NotificationListItemViewModel extends BaseItemViewModel {

  final SavedNotification model;

  NotificationListItemViewModel({required this.model});

  @override
  Widget buildWidget(int index, int length) {
    return NotificationListViewHolder(viewModel: this);
  }

}