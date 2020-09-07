import 'package:project_athens/timeline_flow/domain/timeline_model.dart';

class TimelineDestination {}

class TimelineScreenDestination extends TimelineDestination {}

class SpeechScreenDestination extends TimelineDestination {

  final SpeechModel speechModel;

  SpeechScreenDestination(this.speechModel);

}