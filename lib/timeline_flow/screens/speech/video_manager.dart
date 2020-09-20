import 'package:flick_video_player/flick_video_player.dart';
import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:video_player/video_player.dart';

enum VideoState {NOT_INITIALIZED, PLAYING, PAUSED, ENDED}

class VideoManager {

  final SpeechModel speechModel;

  FlickManager controller;

  VideoManager(this.speechModel) {
    controller = FlickManager(
      videoPlayerController: VideoPlayerController.network(speechModel.videoUrl),
      autoInitialize: true,
      autoPlay: true
    );
  }

  void dispose() {
    controller.dispose();
  }


}