import 'package:project_athens/main/firebase/firebase_messages.dart';

class FirebaseDeputySubscriber {

  final FirebaseMessages _firebaseMessages;

  FirebaseDeputySubscriber(this._firebaseMessages);

  Future<void> subscribeDeputies(List<FirebaseDeputySubscribeModel> models) async {
    models.forEach((model) async {
      await subscribeDeputy(model);
    });
  }

  Future<void> subscribeDeputy(FirebaseDeputySubscribeModel model) async {
    final firebaseMessaging = _firebaseMessages.firebaseMessaging;
    if (model.vote)
      firebaseMessaging.subscribeToTopic("vote-${model.deputyId}");
    if (model.speech)
      firebaseMessaging.subscribeToTopic("speech-${model.deputyId}");
    if (model.interpolation)
      firebaseMessaging.subscribeToTopic("interpolation-${model.deputyId}");
  }

  Future<void> unsubscribeDeputies(List<String> deputyIdList) async {
    deputyIdList.forEach((deputyId) async {
      await unsubscribeDeputy(deputyId);
    });
  }

  Future<void> unsubscribeDeputy(String deputyId) async {
    final firebaseMessaging = _firebaseMessages.firebaseMessaging;
      firebaseMessaging.subscribeToTopic("vote-$deputyId");
      firebaseMessaging.subscribeToTopic("speech-$deputyId");
      firebaseMessaging.subscribeToTopic("interpolation-$deputyId");
  }
  
}

class FirebaseDeputySubscribeModel {

  final String deputyId;
  final bool vote;
  final bool speech;
  final bool interpolation;

  FirebaseDeputySubscribeModel(this.deputyId, this.vote, this.speech, this.interpolation);

}