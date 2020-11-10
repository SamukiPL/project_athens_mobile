import 'dart:math';

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
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
    List<TimelineModel> resultList = await networkMapper(response.events);
    resultList.sort((a, b) => a.date.compareTo(b.date));
    
    return Success<List<TimelineModel>>(resultList);
  }

  @override
  Future<Result<List<WordModel>>> getNounCloud(int cadency, String date) async {
    final response = await timelineApi.getNounCloud(cadency, date);
    final values = response.nouns.values.toList()
      ..sort((a, b) => b.compareTo(a));
    final minValueAllowed = (values.length > 75) ? values[75] : values.last;
    final minimisedNouns = response.nouns
      ..removeWhere((key, value) => value < minValueAllowed || key == "to");

    final test = List<WordModel>();
    minimisedNouns.forEach((key, value) {
      test.add(WordModel(value / (minValueAllowed / 5), key));
    });

    test.shuffle(Random(97518234));

    return Success<List<WordModel>>(test);
  }

}