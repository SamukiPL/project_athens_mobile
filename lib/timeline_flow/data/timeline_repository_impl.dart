import 'dart:math';

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/domain/cloud/word_model.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/timeline_flow/mappers/meetings_dates_mapper.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';

class TimelineRepositoryImpl implements TimelineRepository {

  final TimelineApi timelineApi;

  final TimelineModelMapper networkMapper;

  final MeetingsDatesMapper meetingsDatesMapper = MeetingsDatesMapper();

  TimelineRepositoryImpl(this.timelineApi, this.networkMapper);

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
    List<TimelineModel> resultList = groupVotes(mappedList);

    if (resultList.length > 0) {
      resultList.sort((a, b) => a.date.compareTo(b.date));
    }

    return Success<List<TimelineModel>>(resultList);
  }

  @override
  Future<Result<List<WordModel>>> getNounCloud(int cadency, String date) async {
    final response = await timelineApi.getNounCloud(cadency, date);

    final values = response.nouns.length > 0 ? response.nouns : List();

    final finalWords = List<WordModel>();

    if (values.length > 0) {
      values.sort((a, b) => b.hits.compareTo(a.hits));
      final minValueAllowed = (values.length > 75) ? values[75] : values.last;
      final minimisedNouns = response.nouns
        ..removeWhere((tag) => tag.hits < minValueAllowed.hits || tag.key == "to");

      minimisedNouns.forEach((tag) {
        finalWords.add(WordModel(tag.hits / (minValueAllowed.hits / 5), tag.key));
      });
    }

    finalWords.shuffle(Random(97518234));

    return Success<List<WordModel>>(finalWords);
  }

  List<TimelineModel> groupVotes(List<TimelineModel> models) {
    final groupedVotes = Map<int, List<VotingModel>>();

    List<VotingModel> votesToGroup = models.where((element) => element is VotingModel && element.orderPoint != null).toList();
    votesToGroup.forEach((element) {
      List<VotingModel> group = groupedVotes[element.orderPoint] ?? List();
      group.add(element);
      groupedVotes[element.orderPoint] = group;
    });

    final newList = models.where((element) => !(element is VotingModel && element.orderPoint != null)).toList();

    groupedVotes.values.forEach((group) {
      newList.add(group.createGroupedVotingModel());
    });

    return newList;
  }

}