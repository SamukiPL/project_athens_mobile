import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/future_extension.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:rxdart/rxdart.dart';

class SubscribedDeputiesCache {
  final FirebaseDeputiesUseCase _firebaseDeputiesUseCase;
  final DeleteDeputyUseCase _deleteDeputyUseCase;
  final PutDeputiesUseCase _putDeputiesUseCase;

  SubscribedDeputiesCache(this._firebaseDeputiesUseCase,
      this._deleteDeputyUseCase, this._putDeputiesUseCase);

  List<SubscribedDeputyModel>? _cachedSubscribedDeputies;

  Future<Result<List<SubscribedDeputyModel>>>? awaitingFuture;

  PublishSubject<void> _subscribedDeputiesChanged = PublishSubject<void>();
  Stream<void> get subscribedDeputiesChangedStream =>
      _subscribedDeputiesChanged.stream;

  Future<Result<List<SubscribedDeputyModel>>> get subscribedDeputies async {
    if (_cachedSubscribedDeputies != null) {
      return Success(_cachedSubscribedDeputies!.toList());
    }

    if (awaitingFuture != null) {
      return awaitingFuture!;
    }

    awaitingFuture = _firebaseDeputiesUseCase().whenComplete(() {
      awaitingFuture = null;
    }).onSuccessThen((result) {
      final subscribedDeputies = result.value;

      subscribedDeputies.forEach((subscribedDeputy) => subscribedDeputy
          .notifications
          .updateCallback = () => _updateSubscribedDeputy(subscribedDeputy));

      _cachedSubscribedDeputies = subscribedDeputies;

      return Success(subscribedDeputies);
    });

    return awaitingFuture!;
  }

  Future<SubscribedDeputyModel> getDeputyModelById(String id) =>
      _getDeputyModel((model) => model.id == id);

  Future<SubscribedDeputyModel> getDeputyModelByCardId(int cardId) =>
      _getDeputyModel((model) => model.cardId == cardId);

  Future<List<SubscribedDeputyModel>> getSubsribedDeputies() =>
      subscribedDeputies.onSuccessThen((success) {
        return success.value
            .where((element) => element.notifications.isSubscribed)
            .toList();
      }).onError((error, stackTrace) => List.empty());

  Future<SubscribedDeputyModel> _getDeputyModel(
          bool Function(DeputyModel) condition) =>
      subscribedDeputies
          .onSuccessThen((success) => success.value.firstWhere(condition));

  void _updateSubscribedDeputy(SubscribedDeputyModel subscribedDeputy) async {
    if (subscribedDeputy.notifications.isSubscribed) {
      final putModel = PutDeputyModel(
          subscribedDeputy.id,
          subscribedDeputy.notifications.vote,
          subscribedDeputy.notifications.speech,
          subscribedDeputy.notifications.interpolation);
      await _putDeputiesUseCase.call(PutDeputiesParams([putModel]));
    } else {
      await _deleteDeputyUseCase.call(DeleteDeputyParams(subscribedDeputy.id));
    }

    _subscribedDeputiesChanged.add(null);
  }

  dispose() {
    if (_cachedSubscribedDeputies != null) {
      _cachedSubscribedDeputies!.forEach((element) => element.dispose());
    }

    _subscribedDeputiesChanged.close();
  }
}
