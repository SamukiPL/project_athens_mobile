import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/timeline_flow/screens/speech/video_widget_bloc.dart';

class SpeechBloc extends BaseBloc {

  final VideoWidgetBloc videoBloc;

  SpeechBloc(this.videoBloc);

  VlcPlayerController get controller => videoBloc.controller;

}