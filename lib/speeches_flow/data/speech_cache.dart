import 'dart:collection';

import 'package:project_athens/athens_core/models/speech_model.dart';

class SpeechCache {

  final HashMap<String, SpeechModel> _speechesMap = HashMap();
  final HashMap<String, SpeechModel> _timelineMap = HashMap();

  void clear() => _speechesMap.clear();

  void saveSpeech(SpeechModel model) {
    _speechesMap[model.id] = model;
  }

  void saveSpeeches(List<SpeechModel> models) {
    models.forEach((model) {
      _speechesMap[model.id] = model;
    });
  }

  void saveTimelineSpeeches(List<SpeechModel> models) {
    models.forEach((model) {
      _timelineMap[model.id] = model;
    });
  }

  bool hasSpeech(String speechId, bool isNormalSpeech) => (isNormalSpeech) ? _speechesMap.containsKey(speechId) : _timelineMap.containsKey(speechId);

  SpeechModel getSpeech(String speechId, bool isNormalSpeech) => (isNormalSpeech) ? _speechesMap[speechId]! : _timelineMap[speechId]!;

}