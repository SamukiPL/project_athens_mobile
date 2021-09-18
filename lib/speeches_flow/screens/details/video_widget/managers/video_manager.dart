import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/next_video_overlay_bloc.dart';

abstract class VideoManager {
  final SpeechModel speechModel;
  final bool isNormalSpeech;

  final nextVideoOverlayBloc = NextVideoOverlayBloc();
  final WakelockService wakelock;

  VideoManager(this.speechModel, this.isNormalSpeech, this.wakelock);

  Widget buildVideoWidget();

  void dispose() {
    wakelock.tryToDisableLock();
    nextVideoOverlayBloc.dispose();
  }
}