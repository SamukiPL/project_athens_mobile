import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/deputies_utils/data/network/request/put_deputies_request.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_repository.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';

import 'network/deputies_api.dart';

class PutDeputiesRepositoryImpl
    implements PutDeputiesRepository {
  final DeputiesApi deputiesApi;

  final FirebaseDeputySubscriber deputySubscriber;

  PutDeputiesRepositoryImpl(this.deputiesApi, this.deputySubscriber);

  @override
  Future<Result> putDeputies(
      PutDeputiesParams params) async {
    final request = PutDeputiesRequest(params.deputies
        .map((model) => Deputy(model.deputyId, Notifications(model.vote, model.speech, model.interpolation)))
        .toList());
    final response = await deputiesApi.putDeputies(params.cadency, request);
    if (response.isSuccessful) {
      await deputySubscriber.subscribeDeputies(params.deputies.map((model) =>
          model.toFirebaseDeputySubscribeModel()
      ));
      deputiesApi.dispose();
    }
    return Success<int>(response.statusCode);
  }
}
