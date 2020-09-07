import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

enum VideoState {NOT_INITIALIZED, PLAYING, PAUSED, ENDED}

class VideoWidgetBloc extends BaseChangeNotifier {

  VideoState _state = VideoState.NOT_INITIALIZED;

  VideoState get state => _state;

  VlcPlayerController controller;

  VideoWidgetBloc() {
    controller = VlcPlayerController(
      onInit: () {
        controller.play();
        _state = VideoState.PLAYING;
        notifyListeners();
      },
    );
  }

  void videoClick() {
    switch(state) {
      case VideoState.NOT_INITIALIZED:
        break;
      case VideoState.PLAYING:
        _pause();
        break;
      case VideoState.PAUSED:
        _start();
        break;
      case VideoState.ENDED:
        // TODO: Handle this case.
        break;
    }
  }

  void _start() {
    controller.play();
    _state = VideoState.PLAYING;
    notifyListeners();
  }

  void _pause() {
    controller.pause();
    _state = VideoState.PAUSED;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


}