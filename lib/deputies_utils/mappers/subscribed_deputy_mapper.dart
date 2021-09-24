import 'package:collection/collection.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/deputies_utils/data/network/response/subscribed_deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class SubscribedDeputyMapper extends DataMapper<DeputyModel, SubscribedDeputyModel> {
  final List<SubscribedDeputyResponse> subscribedDeputies;

  SubscribedDeputyMapper(this.subscribedDeputies);

  @override
  SubscribedDeputyModel transform(DeputyModel data) {
    SubscribedDeputyResponse? subscribedDeputy = subscribedDeputies.firstWhereOrNull((element) => element.cadencyDeputyId == data.id);

    bool isSubscribed = true;
    if (subscribedDeputy == null) {
      subscribedDeputy = SubscribedDeputyResponse(null, null, null, false, data.id, Notifications(false, false, false));
      isSubscribed = false;
    }

    final subscribedDeputyNotifications = SubscribedDeputyNotificationsNotifier(
      subscribedDeputy.notifications.vote,
      subscribedDeputy.notifications.speech,
      subscribedDeputy.notifications.interpolation,
      isSubscribed,
    );

    return SubscribedDeputyModel.fromDeputyModel(
      data,
      subscribedDeputy.isPrimary,
      subscribedDeputy.cadencyDeputyId,
      subscribedDeputyNotifications,
    );
  }
}