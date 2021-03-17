import 'package:project_athens/athens_core/data/base_requests/base_fetch_query.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/domain/speeches_list_by_deputy_params.dart';
import 'package:project_athens/deputies_flow/domain/speeches_list_by_deputy_repository.dart';

class SpeechesListByDeputyRepositoryImpl extends SpeechesListByDeputyRepository {
  final DeputiesDetailsApi api;

  SpeechesListByDeputyRepositoryImpl(this.api);

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> fetchItems(int limit, int offset) async {

  }

  @override
  Stream<Result<List<SpeechModel>>> getItems(SpeechesListByDeputyParams params) async {
    final query = BaseFetchQuery(offset: 0, limit: 20);
    return api.getSpeechesByDeputy(params.cadencyDeputyId, query).asStream();
  }

  @override
  Future<void> refreshItems() {
    // TODO: implement refreshItems
    throw UnimplementedError();
  }

}