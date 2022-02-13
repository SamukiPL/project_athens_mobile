import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputies_easy_filter.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputiesListDataSource
    extends NetworkListDataSource<DeputyModel, DeputiesListParams> {
  final SubscribedDeputiesCache _deputiesCache;

  DeputiesListDataSource(this._deputiesCache);

  @override
  Future<Result<List<DeputyModel>>> call(DeputiesListParams params) async {
    var deputiesResult = await _deputiesCache.subscribedDeputies;
    if (deputiesResult is Success<List<SubscribedDeputyModel>>) {
      deputiesResult = _filterBySearchQuery(deputiesResult, params.searchQuery);
      deputiesResult = _filterByEasyFilter(deputiesResult, params.easyFilter);
    }
    return deputiesResult;
  }

  Success<List<SubscribedDeputyModel>> _filterBySearchQuery(
      Success<List<SubscribedDeputyModel>> result, String searchQuery) {
    if (searchQuery.isNotEmpty) {
      final deputies = result.value
          .where((element) => element.name.containsIgnoreCase(searchQuery))
          .toList();
      return Success(deputies);
    } else {
      return result;
    }
  }

  Success<List<SubscribedDeputyModel>> _filterByEasyFilter(
      Success<List<SubscribedDeputyModel>> result,
      DeputiesEasyFilter? easyFilter) {
    if (easyFilter is Subscribed) {
      final deputies = result.value
          .where((element) => element.notifications.isSubscribed)
          .toList();
      return Success(deputies);
    } else if (easyFilter is ParliamentClub) {
      final deputies = result.value
          .where((element) => element.clubId == easyFilter.id)
          .toList();
      return Success(deputies);
    } else {
      return result;
    }
  }
}
