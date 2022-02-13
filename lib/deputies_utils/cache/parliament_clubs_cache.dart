import 'package:collection/src/iterable_extensions.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/future_extension.dart';
import 'package:project_athens/deputies_utils/cache/cache_errors.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_use_case.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class ParliamentClubsCache {
  final GetParliamentClubsUseCase _getParliamentClubsUseCase;

  ParliamentClubsCache(this._getParliamentClubsUseCase);

  Future<Result<List<ParliamentClubModel>>>? _parliamentClubsFuture;
  List<ParliamentClubModel>? _cachedParliamentClubs;

  Future<Result<List<ParliamentClubModel>>> get parliamentClubs {
    if (_cachedParliamentClubs != null) {
      return Future.value(Success(_cachedParliamentClubs!.toList()));
    }

    if (_parliamentClubsFuture != null) {
      return _parliamentClubsFuture!;
    }

    _parliamentClubsFuture =
        _getParliamentClubsUseCase()
            .whenComplete(() {
      _parliamentClubsFuture = null;
    }).then((clubsResult) {
      if (clubsResult is Success<List<ParliamentClubModel>>) {
        _cachedParliamentClubs = clubsResult.value;
        return Success(clubsResult.value);
      } else {
        return Failure(ParliamentClubsCacheError());
      }
    });

    return _parliamentClubsFuture!;
  }

  Future<ParliamentClubModel?> getParliamentClubModel(String? id) =>
      parliamentClubs.onSuccessThen(
          (success) => success.value.firstWhereOrNull((element) => element.id == id));
}
