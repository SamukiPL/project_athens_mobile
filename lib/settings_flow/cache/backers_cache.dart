import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/data/network/response/get_backers_response.dart';
import 'package:project_athens/settings_flow/domain/settings/get_backers_use_case.dart';

class BackersCache {
  final GetBackersUseCase _getBackersUseCase;

  BackersCache(this._getBackersUseCase);

  List<Backer> _cachedBackers;

  Future<Result<List<Backer>>> get backers async {
    if (_cachedBackers != null) {
      return Success(_cachedBackers);
    }

    final result = await _getBackersUseCase(BaseParams()).then((result) {
      if (result is Success<GetBackersResponse>) {
        _cachedBackers = result.value.backers;
        return Success(result.value.backers);
      } else {
        return result;
      }
    });

    return result;
  }
  
  Future<bool> get hasUserBacked async {
    final cachedBackers = await backers;
    
    if (cachedBackers is Success<List<Backer>>) {
      return cachedBackers.value.firstWhere((element) => element.isCurrentUser != null && element.isCurrentUser == true) != null;
    } else {
      return false;
    }
    
  }
}