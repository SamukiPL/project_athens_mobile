import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/network/response/subscribed_deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/deputies_utils/mappers/subscribed_deputy_mapper.dart';

class SubscribedDeputiesCache {

  final DeputiesCache _deputiesCache;
  final FirebaseDeputiesUseCase _firebaseDeputiesUseCase;
  final DeleteDeputyUseCase _deleteDeputyUseCase;
  final PutDeputiesUseCase _putDeputiesUseCase;

  SubscribedDeputiesCache(this._deputiesCache, this._firebaseDeputiesUseCase, this._deleteDeputyUseCase, this._putDeputiesUseCase);

  List<SubscribedDeputyModel> _cachedSubscribedDeputies;

  Future<Result<List<SubscribedDeputyModel>>> get subscribedDeputies async {
    if (_cachedSubscribedDeputies != null) {
      return Success(_cachedSubscribedDeputies.toList());
    }

    final cachedDeputies = await _deputiesCache.deputies;

    if (cachedDeputies is Failure<List<DeputyModel>>) {
      return Failure(cachedDeputies.exception);
    }

    final result = await _firebaseDeputiesUseCase(BaseDeputiesParams(9)).then((result) {
      if (result is Success<List<SubscribedDeputyResponse>>) {
        final SubscribedDeputyMapper mapper = SubscribedDeputyMapper(result.value);

        final subscribedDeputies = mapper.call((cachedDeputies as Success<List<DeputyModel>>).value);

        subscribedDeputies.forEach((subscribedDeputy) => subscribedDeputy.notifications.updateCallback = () => _updateSubscribedDeputy(subscribedDeputy));

        _cachedSubscribedDeputies = subscribedDeputies;

        return Success(subscribedDeputies);
      } else {
        return result;
      }
    });

    return result;
  }

  Future<DeputyModel> getDeputyModelById(String id) =>
      _getDeputyModel((model) => model.id == id);

  Future<DeputyModel> getDeputyModelByCardId(int cardId) =>
      _getDeputyModel((model) => model.cardId == cardId);

  Future<DeputyModel> _getDeputyModel(bool Function(DeputyModel) condition) async {
    if (_cachedSubscribedDeputies != null && _cachedSubscribedDeputies.isNotEmpty)
      return _cachedSubscribedDeputies.firstWhere((element) => condition(element));

    await subscribedDeputies;

    return _cachedSubscribedDeputies.firstWhere((element) => condition(element));
  }

  void _updateSubscribedDeputy(SubscribedDeputyModel subscribedDeputy) async {
    print('about to perform save operation');

    if (subscribedDeputy.notifications.isSubscribed) {
      final putModel = PutDeputyModel(
          subscribedDeputy.id,
          subscribedDeputy.notifications.vote,
          subscribedDeputy.notifications.speech,
          subscribedDeputy.notifications.interpolation
      );
      await _putDeputiesUseCase.call(PutDeputiesParams(9, [putModel]));
    } else {
      await _deleteDeputyUseCase.call(DeleteDeputyParams(9, subscribedDeputy.id));
    }
  }

  dispose () {
    if (_cachedSubscribedDeputies != null) {
      _cachedSubscribedDeputies.forEach((element) => element.dispose());
    }
  }
}