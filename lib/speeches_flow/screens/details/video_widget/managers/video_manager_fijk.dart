import 'dart:developer';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:fijkplayer_skin/fijkplayer_skin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';

class VideoManagerFijk extends VideoManager with WidgetsBindingObserver {
  late FijkPlayer player;

  VideoManagerFijk(
      SpeechModel speechModel, bool isNormalSpeech, WakelockService wakelock)
      : super(speechModel, isNormalSpeech, wakelock) {
    // controller = VlcPlayerController.network(
    //     speechModel.videoUrl.replaceAll("&nolimit=1", ""));


    player = FijkPlayer();
    player.setDataSource(
        speechModel.videoUrl.replaceAll("&nolimit=1", "").substring(0, speechModel.videoUrl.indexOf('&name=')),
        autoPlay: true
    );

    player.addListener(() {
      if (player.value.videoRenderStart == true) {
        wakelock.tryToEnableLock();
      }
    });

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget buildVideoWidget(BuildContext context) {
    final ShowConfigAbs cfg = AthensShowConfig();
    final mediaQuery = MediaQuery.of(context);
    final preferredHeight = mediaQuery.size.width * (9 / 16);

    return Container(
        width: mediaQuery.size.width,
        height: preferredHeight,
        child:
        FijkView(
            player: player,
            fit: FijkFit.fitWidth,
            color: Colors.black,
            // color: Colors.black,
            panelBuilder: (player, data, context, viewSize, texturePos) => CustomFijkPanel(
              player: player,
              viewSize: viewSize,
              texturePos: texturePos,
              pageContent: context,
              playerTitle: "标题",
              showConfig: cfg,
              videoEnd: () => nextVideoOverlayBloc.pushOnNext(speechModel.nextPersonSpeech),
            )
        )
    );
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    // FijkPlayer does not stop when we minimize app or turn of screen
    // so we need to pause video by ourselves
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      player.pause();
    }
  }

  @override
  void dispose() async {
    await player.stop();
    await player.release();

    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }
}

class AthensShowConfig implements ShowConfigAbs {
  bool drawerBtn = false;
  bool nextBtn = false;
  bool speedBtn = true;
  bool topBar = false;
  bool lockBtn = true;
  bool autoNext = true;
  bool bottomPro = true;
  bool stateAuto = true;
}