import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/next_video_overlay.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/video_manager.dart';

class SpeechVideoWidget extends StatelessWidget {
  final VideoManager videoManager;

  const SpeechVideoWidget({Key key, this.videoManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlickVideoPlayer(
          flickManager: videoManager.controller,
        ),
        NextVideoOverlay(
          bloc: videoManager.nextVideoOverlayBloc,
          isNormalSpeech: videoManager.isNormalSpeech,
        )
      ],
    );
  }
}
