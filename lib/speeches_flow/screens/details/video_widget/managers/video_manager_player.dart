import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';
import 'package:video_player/video_player.dart';

class VideoManagerPlayer extends VideoManager {
  late FlickManager controller;

  VideoManagerPlayer(
      SpeechModel speechModel, bool isNormalSpeech, WakelockService wakelock)
      : super(speechModel, isNormalSpeech, wakelock) {
    controller = FlickManager(
        videoPlayerController: VideoPlayerController.network(
            speechModel.videoUrl.replaceAll("&nolimit=1", "")),
        autoInitialize: true,
        autoPlay: true,
        onVideoEnd: () =>
            nextVideoOverlayBloc.pushOnNext(speechModel.nextPersonSpeech));

    final flickVideo = controller.flickVideoManager;
    flickVideo?.addListener(() async {
      if (flickVideo.isPlaying || flickVideo.isVideoInitialized) {
        wakelock.tryToEnableLock();
      } else if (flickVideo.isVideoEnded) {
        wakelock.tryToDisableLock();
      }
    });
  }

  @override
  Widget buildVideoWidget(BuildContext context) {
    return FlickVideoPlayer(flickManager: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
