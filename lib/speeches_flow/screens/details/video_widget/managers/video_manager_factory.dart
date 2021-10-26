import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager.dart';
import 'package:project_athens/speeches_flow/screens/details/video_widget/managers/video_manager_fijk.dart';

class VideoManagerFactory {

  static VideoManager create(speechModel, isNormalSpeech, wakelock) {
      return VideoManagerFijk(speechModel, isNormalSpeech, wakelock);
  }
}