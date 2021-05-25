import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

class SubscribedDeputyModel extends DeputyModel {
  final bool isPrimary;
  final String cadencyDeputyId;
  final SubscribedDeputyNotificationsNotifier notifications;

  SubscribedDeputyModel(
      this.isPrimary,
      this.cadencyDeputyId,
      this.notifications,
      String id,
      String name,
      String thumbnailUrl,
      String club,
      String clubId,
      int cardId)
    : super(
      id: id,
      name: name,
      cardId: cardId,
      club: club,
      clubId: clubId,
      thumbnailUrl: thumbnailUrl
    );

  SubscribedDeputyModel.fromDeputyModel(
    DeputyModel model,
      this.isPrimary,
      this.cadencyDeputyId,
      this.notifications
  ) : super(id: model.id, name: model.name, club: model.club, cardId: model.cardId, thumbnailUrl: model.thumbnailUrl);

  dispose() {
    notifications.dispose();
  }
}

class SubscribedDeputyNotificationsNotifier extends BaseChangeNotifier {
  bool vote;
  bool speech;
  bool interpolation;
  bool isSubscribed;

  SubscribedDeputyNotificationsNotifier(this.vote, this.speech, this.interpolation, this.isSubscribed) : super();

  Function() updateCallback;

  setIsSubscribed(bool state) {
    if (updateCallback == null) {
      return;
    }

    isSubscribed = state;

    if (isSubscribed) {
      speech = true;
    }

    notifyListeners();
    updateCallback.call();
  }

  setSpeech(bool state) {
    if (updateCallback == null) {
      return;
    }

    speech = state;

    notifyListeners();
    updateCallback.call();
  }

  setInterpolation(bool state) {
    if (updateCallback == null) {
      return;
    }

    interpolation = state;

    notifyListeners();
    updateCallback.call();
  }

  setVote(bool state) {
    if (updateCallback == null) {
      return;
    }

    vote = state;

    notifyListeners();
    updateCallback.call();
  }

  dispose() {
    super.dispose();
  }
}