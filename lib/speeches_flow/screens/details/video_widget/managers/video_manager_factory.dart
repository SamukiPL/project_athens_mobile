import 'dart:io';

import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager_player.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager_vlc.dart';

class VideoManagerFactory {

  static VideoManager create(speechModel, isNormalSpeech, wakelock) {
    // if (Platform.isIOS) {
      return VideoManagerVlc(speechModel, isNormalSpeech, wakelock);
    // } else {
    //   return VideoManagerPlayer(speechModel, isNormalSpeech, wakelock);
    // }
  }

}