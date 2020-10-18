import 'package:flick_video_player/flick_video_player.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/speeches_flow/screens/details/video_manager.dart';

class SpeechDetailsBloc extends BaseBloc {

  final VideoManager videoManager;

  SpeechDetailsBloc(this.videoManager);

  FlickManager get controller => videoManager.controller;

  @override
  void dispose() {
    videoManager.dispose();
    super.dispose();
  }

}