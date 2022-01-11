
import 'package:project_athens/athens_core/data/word_model/noun_tag.dart';
import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/data/word_model/word_model_mapper.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/data/speech_queue_setter.dart';
import 'package:project_athens/timeline_flow/data/votes_grouper.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/timeline_flow/mappers/meetings_dates_mapper.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';

class TimelineRepositoryImpl implements TimelineRepository {
  final TimelineApi timelineApi;
  final TimelineModelMapper networkMapper;
  final SpeechQueueSetter speechQueueSetter;

  final MeetingsDatesMapper meetingsDatesMapper = MeetingsDatesMapper();
  final VotesGrouper votesGrouper = VotesGrouper();

  TimelineRepositoryImpl(this.timelineApi, this.networkMapper, this.speechQueueSetter);

  @override
  Future<Result> getMeetingsDates(int cadency) async {
    final response = await timelineApi.getMeetingsDates(cadency);
    List<MeetingDate> resultList = meetingsDatesMapper(response.meetings);

    return Success<List<MeetingDate>>(resultList);
  }

  @override
  Future<Result> getTimelineForDay(int cadency, String date) async {
    final response = await timelineApi.getAllDeputies(cadency, date);
    List<TimelineModel> mappedList = await networkMapper(response.events);
    List<TimelineModel> speechesCorrectedList = speechQueueSetter.createQueues(mappedList);
    List<TimelineModel> resultList = votesGrouper.groupVotes(speechesCorrectedList);

    if (resultList.length > 0) {
      resultList.sort((a, b) => a.date.compareTo(b.date));
    }

    final resultListWithAds = addAds(resultList);

    return Success<List<TimelineModel>>(resultListWithAds);
  }

  @override
  Future<Result<List<WordModel>>> getNounCloud(int cadency, String date) async {
    final response = await timelineApi.getNounCloud(cadency, date);

    final values = response.nouns.length > 0 ? response.nouns : List<NounTag>.empty();

    final List<WordModel> finalWords = mapToWordModel(values);

    return Success<List<WordModel>>(finalWords);
  }

  List<TimelineModel> addAds(List<TimelineModel> resultList) {
    final mutableModelsList = resultList.toList(growable: true);
    final indexesToAdd = new List<int>.generate((resultList.length / 5).floor(), (index) => 5 + (5 * index));
    indexesToAdd.forEach((index) {
      mutableModelsList.insert(index, AdTimelineModel());
    });

    return mutableModelsList.toList(growable: false);
  }
}

