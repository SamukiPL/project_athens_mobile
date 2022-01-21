import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/list_impl/notification_list_item_view_model.dart';

class NotificationItemViewModelFactory extends ItemViewModelFactory {

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    switch (model.runtimeType) {
      case NotificationModel:
        return NotificationListItemViewModel(model: model as NotificationModel);
    }
    return null;
  }

}
