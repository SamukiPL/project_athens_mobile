import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/speeches_flow/data/details_speech_network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class GetSpeechUseCase extends BaseUseCase {

  final DetailsSpeechNetworkDataSource _dataSource;

  GetSpeechUseCase(this._dataSource);

  @override
  Future<Result> call(params) => _dataSource().safeApiCall();
}
