import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/network/response/subscribed_deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_repository.dart';

class FirebaseDeputiesRepositoryImpl extends FirebaseDeputiesRepository {

  final DeputiesApi _deputiesApi;

  final FirebaseDeputySubscriber _deputySubscriber;

  FirebaseDeputiesRepositoryImpl(this._deputiesApi, this._deputySubscriber);

  @override
  Future<Result<bool>> initFirebaseDeputies(BaseDeputiesParams params) async {
    final response = await _deputiesApi.getSubscribedDeputies(params.cadency);
    final deputies = (response.body as List)
        .map((json) => SubscribedDeputyResponse.fromJson(json))
        .toList();
    await _deputySubscriber.subscribeDeputies(deputies.map((model) =>
        model.toFirebaseDeputySubscribeModel()
    ).toList());
    _deputiesApi.dispose();
    return Success<bool>(response.isSuccessful);
  }

}