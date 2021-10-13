import 'package:fijkplayer/fijkplayer.dart';
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
    // return VlcPlayer(controller: controller, aspectRatio: 16 / 9);
    final player = FijkPlayer();
    player.setDataSource(
      speechModel.videoUrl.replaceAll("&nolimit=1", "").substring(0, speechModel.videoUrl.indexOf('&name=')),
        autoPlay: true
    );
    return Container(
        width: 400,
        height: 400,
        child:
      FijkView(
        player: player,
      )
    );

  }


  @override
  void dispose() {
    controller.stopRendererScanning();
    controller.dispose();
    super.dispose();
  }
}
