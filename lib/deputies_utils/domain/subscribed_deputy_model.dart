import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_notifications_notifier.dart';
import 'package:rxdart/rxdart.dart';

class SubscribedDeputyModel extends DeputyModel {
  final bool isPrimary;
  final String cadencyDeputyId;
  final SubscribedDeputyNotifications notifications;

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



  dispose() {
    notifications.dispose();
  }
}

class SubscribedDeputyNotifications {
  bool vote;
  bool speech;
  bool interpolation;
  bool isSubscribed;

  SubscribedDeputyNotifications(this.vote, this.speech, this.interpolation, this.isSubscribed);

  final SubscribedDeputyNotificationsNotifier notificationsChangeNotifier = SubscribedDeputyNotificationsNotifier();

  Function() updateCallback;

  setIsSubscribed(bool state) {
    if (updateCallback == null) {
      return;
    }

    isSubscribed = state;

    if (isSubscribed) {
      speech = true;
    }

    notificationsChangeNotifier.notifyListeners();
    updateCallback.call();
  }

  setSpeech(bool state) {
    if (updateCallback == null) {
      return;
    }

    speech = state;

    notificationsChangeNotifier.notifyListeners();
    updateCallback.call();
  }

  setInterpolation(bool state) {
    if (updateCallback == null) {
      return;
    }

    interpolation = state;

    notificationsChangeNotifier.notifyListeners();
    updateCallback.call();
  }

  setVote(bool state) {
    if (updateCallback == null) {
      return;
    }

    vote = state;

    notificationsChangeNotifier.notifyListeners();
    updateCallback.call();
  }

  dispose() {
    notificationsChangeNotifier.dispose();
  }
}