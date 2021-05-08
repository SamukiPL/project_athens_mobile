import 'package:flick_video_player/flick_video_player.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/next_video_overlay_bloc.dart';
import 'package:video_player/video_player.dart';

enum VideoState {NOT_INITIALIZED, PLAYING, PAUSED, ENDED}

class VideoManager {

  final SpeechModel speechModel;
  final bool isNormalSpeech;

  final nextVideoOverlayBloc = NextVideoOverlayBloc();

  FlickManager controller;

  VideoManager(this.speechModel, this.isNormalSpeech) {
    controller = FlickManager(
      videoPlayerController: VideoPlayerController.network(speechModel.videoUrl.replaceAll("&nolimit=1", "")),
      autoInitialize: true,
      autoPlay: true,
      onVideoEnd: () => nextVideoOverlayBloc.pushOnNext(speechModel.nextPersonSpeech)
    );
  }

  void dispose() {
    controller.dispose();
    nextVideoOverlayBloc.dispose();
  }

}