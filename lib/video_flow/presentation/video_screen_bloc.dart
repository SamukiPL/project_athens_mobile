import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoScreenBloc extends BaseBloc {
  VlcPlayerController controller;

  VideoScreenBloc() {
    controller = VlcPlayerController(
      onInit: () {
        controller.play();
      }
    );
  }

  @override
  void dispose() {
    controller.dispose();
  }
}
