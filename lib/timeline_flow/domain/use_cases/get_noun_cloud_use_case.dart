import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';

class GetNounCloudUseCase extends BaseUseCase<TimelineParameters> {

  final TimelineRepository _timelineRepository;

  GetNounCloudUseCase(this._timelineRepository);

  @override
  Future<Result<List<WordModel>>> call(TimelineParameters params) =>
      _timelineRepository.getNounCloud(
          params.cadency,
          params.date
      );

}