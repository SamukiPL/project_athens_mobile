import 'package:flick_video_player/flick_video_player.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/timeline_flow/screens/speech/video_manager.dart';

class SpeechBloc extends BaseBloc {

  final VideoManager videoManager;

  SpeechBloc(this.videoManager);

  FlickManager get controller => videoManager.controller;

  @override
  void dispose() {
    videoManager.dispose();
    super.dispose();
  }

}