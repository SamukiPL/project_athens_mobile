import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/domain/settings/backer_model.dart';
import 'package:project_athens/settings_flow/domain/settings/get_backers_use_case.dart';

class BackersCache {
  final GetBackersUseCase _getBackersUseCase;

  BackersCache(this._getBackersUseCase);

  List<BackerModel> _cachedBackers;

  Future<Result<List<BackerModel>>> get backers async {
    if (_cachedBackers != null) {
      return Success(_cachedBackers);
    }

    final result = await _getBackersUseCase(BaseParams()).then((result) {
      if (result is Success<List<BackerModel>>) {
        _cachedBackers = result.value;
        return Success(result.value);
      } else {
        return result;
      }
    });

    return result;
  }
  
  Future<bool> get hasUserBacked async {
    final cachedBackers = await backers;
    
    if (cachedBackers is Success<List<BackerModel>>) {
      return cachedBackers.value.firstWhere((element) => element.isCurrentUser != null && element.isCurrentUser == true) != null;
    } else {
      return false;
    }
    
  }
}