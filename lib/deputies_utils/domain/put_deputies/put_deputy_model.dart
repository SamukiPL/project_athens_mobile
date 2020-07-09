import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';

class PutDeputyModel {
  final String deputyId;
  final bool vote;
  final bool speech;
  final bool interpolation;

  PutDeputyModel(this.deputyId, this.vote, this.speech, this.interpolation);
}

extension PutDeputyModelExt on PutDeputyModel {
  FirebaseDeputySubscribeModel toFirebaseDeputySubscribeModel() =>
      FirebaseDeputySubscribeModel(deputyId, vote, speech, interpolation);
}
