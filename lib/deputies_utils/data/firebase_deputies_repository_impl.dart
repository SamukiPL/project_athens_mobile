import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/future_extension.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/network/response/subscribed_deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_repository.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/deputies_utils/mappers/subscribed_deputy_mapper.dart';
import 'package:project_athens/guest_flow/domain/logged_state.dart';

class FirebaseDeputiesRepositoryImpl extends FirebaseDeputiesRepository {

  final DeputiesApi _deputiesApi;
  final DeputiesCache _deputiesCache;

  final FirebaseDeputySubscriber _deputySubscriber;
  final LoggedState loggedState;

  FirebaseDeputiesRepositoryImpl(
      this._deputiesApi, this._deputiesCache, this._deputySubscriber,
      {this.loggedState = const LoggedState.userLogged()});

  @override
  Future<Result<List<SubscribedDeputyModel>>> initFirebaseDeputies() async {
    final deputies = await _deputiesCache.deputies.onSuccessThen((success) => success.value);
    final response = await getSubscribedDeputies();

    final mapper = SubscribedDeputyMapper(response);
    final models = mapper(deputies);

    await _deputySubscriber.subscribeDeputies(response.map((model) =>
        model.toFirebaseDeputySubscribeModel()
    ).toList());

    return Success<List<SubscribedDeputyModel>>(models);
  }

  Future<List<SubscribedDeputyResponse>> getSubscribedDeputies() async {
    if (loggedState.isGuest) {
      return List<SubscribedDeputyResponse>.empty();
    }
    return _deputiesApi.getSubscribedDeputies();
  }
}