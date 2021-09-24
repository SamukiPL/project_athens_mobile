import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';

class SpeechQueueSetter {
  final SpeechCache _speechCache;

  SpeechQueueSetter(this._speechCache);

  List<TimelineModel> createQueues(List<TimelineModel> models) {
    List<TimelineModel> listWithoutSpeeches =
        models.where((element) => !(element is SpeechModel)).toList();
    List<SpeechModel> speeches = models
        .where((element) => element is SpeechModel)
        .map((e) => e as SpeechModel)
        .toList();

    if (speeches.length > 0) {
      speeches.sort((a, b) => a.date.compareTo(b.date));
    }

    final speechesWithQueues = setQueues(speeches);
    _speechCache.saveTimelineSpeeches(speechesWithQueues);

    listWithoutSpeeches.addAll(speechesWithQueues);
    return listWithoutSpeeches;
  }

  List<SpeechModel> setQueues(List<SpeechModel> oldList) {
    return oldList
        .asMap()
        .map((index, value) {
          final newSpeech = value.changePersonSpeeches(
              newNextPersonSpeech: provideNextPersonModel(index, oldList),
              newPreviousPersonSpeech:
                  providePreviousPersonModel(index, oldList));
          return MapEntry(index, newSpeech);
        })
        .values
        .toList(growable: false);
  }

  PersonSpeechModel? provideNextPersonModel(
      int index, List<SpeechModel> oldList) {
    if (index < oldList.length - 1) {
      final speech = oldList[index + 1];
      return PersonSpeechModel(
          name: speech.personName,
          thumbnailUrl: speech.thumbnailUrl,
          speechId: speech.id);
    }
    return null;
  }

  PersonSpeechModel? providePreviousPersonModel(
      int index, List<SpeechModel> oldList) {
    if (index > 0 && index < oldList.length) {
      final speech = oldList[index - 1];
      return PersonSpeechModel(
          name: speech.personName,
          thumbnailUrl: speech.thumbnailUrl,
          speechId: speech.id);
    }
    return null;
  }
}
