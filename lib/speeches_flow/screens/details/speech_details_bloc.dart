import 'package:flick_video_player/flick_video_player.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/speeches_flow/screens/details/video_manager.dart';

class SpeechDetailsBloc extends BaseBloc {

  final SpeechModel _speechModel;
  
  final VideoManager _videoManager;

  final DeputiesCache _deputiesCache;

  SpeechDetailsBloc(this._speechModel, this._videoManager, this._deputiesCache) {
    _initDeputyModel();
  }

  DeputyModel deputyModel;

  FlickManager get controller => _videoManager.controller;

  @override
  void dispose() {
    _videoManager.dispose();
    super.dispose();
  }
  
  Future<void> _initDeputyModel() async {
    deputyModel = await _deputiesCache.getDeputyModel(_speechModel.deputyId);
  }

}