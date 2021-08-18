import 'package:flutter/cupertino.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';

class VideoManagerVlc extends VideoManager {
  late VlcPlayerController controller;

  VideoManagerVlc(
      SpeechModel speechModel, bool isNormalSpeech, WakelockService wakelock)
      : super(speechModel, isNormalSpeech, wakelock) {
    controller = VlcPlayerController.network(
        speechModel.videoUrl.replaceAll("&nolimit=1", ""));

    controller.addListener(() async {
      if (await controller.isPlaying() == true) {
        wakelock.tryToEnableLock();
      }
    });
  }

  @override
  Widget buildVideoWidget() {
    return VlcPlayer(controller: controller, aspectRatio: 16 / 9);
  }

  @override
  void dispose() {
    controller.stopRendererScanning();
    controller.dispose();
    super.dispose();
  }
}
