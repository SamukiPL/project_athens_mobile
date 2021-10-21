import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/dashboard_tiles_data_model.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';

class DashboardTilesDataMapper extends AsyncDataMapper<DashboardResponse, DashboardTilesDataModel> {
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  late DashboardSimpleAbsentVoteDeputiesCounterMapper absentVoteMapper;
  late DashboardSimpleSpeechesCounterDeputiesCounterMapper speechesCounterMapper;
  late DashboardSimpleDeputyCounterPerYearMapper counterPerYearMapper;

  DashboardTilesDataMapper(this._subscribedDeputiesCache) {
    absentVoteMapper = DashboardSimpleAbsentVoteDeputiesCounterMapper(_subscribedDeputiesCache);
    speechesCounterMapper = DashboardSimpleSpeechesCounterDeputiesCounterMapper(_subscribedDeputiesCache);
    counterPerYearMapper = DashboardSimpleDeputyCounterPerYearMapper(_subscribedDeputiesCache);
  }

  @override
  Future<DashboardTilesDataModel> transform(DashboardResponse response) async {
    DashboardNearestMeetingTileDataModel? nearestMeeting;
    if (response.meeting != null) {
      nearestMeeting = DashboardNearestMeetingTileDataModel(response.meeting!.nearestMeeting, response.meeting!.nearestPastMeeting);
    }

    DashboardSimpleDeputiesCounter? absentVote;
    if (response.absentVote != null) {
      absentVote = DashboardSimpleDeputiesCounter(
        await Future.wait(response.absentVote!.perDeputy.map((deputy) => absentVoteMapper.transform(deputy))),
        response.absentVote!.updateAt,
      );
    }

    DashboardSimpleDeputiesCounter? speechesCounter;
    if (response.speechesCounter != null) {
      speechesCounter = DashboardSimpleDeputiesCounter(
        await Future.wait(response.speechesCounter!.perDeputy.map((deputy) => speechesCounterMapper.transform(deputy))),
        response.speechesCounter!.updateAt,
      );
    }

    DashboardSimpleDeputiesCounterPerYearDataModel? absentVotePerYear;
    if (response.absentVotePerYear != null) {
      absentVotePerYear = DashboardSimpleDeputiesCounterPerYearDataModel(
        await Future.wait(response.absentVotePerYear!.perDeputy.map((deputy) => counterPerYearMapper.transform(deputy)).toList()),
        response.absentVotePerYear!.updateAt
      );
    }

    DashboardSimpleDeputiesCounterPerYearDataModel? speechesCounterPerYear;
    if (response.speechesCounterPerYear != null) {
      speechesCounterPerYear = DashboardSimpleDeputiesCounterPerYearDataModel(
          await Future.wait(response.speechesCounterPerYear!.perDeputy.map((deputy) => counterPerYearMapper.transform(deputy)).toList()),
          response.speechesCounterPerYear!.updateAt
      );
    }

    return DashboardTilesDataModel(
      nearestMeeting: nearestMeeting,
      speechesCounterPerYear: speechesCounterPerYear,
      speechesCounter: speechesCounter,
      absentVote: absentVote,
      absentVotePerYear: absentVotePerYear
    );
  }
}

class DashboardSimpleAbsentVoteDeputiesCounterMapper extends AsyncDataMapper<DashboardAbsentVoteCounterDeputy, DashboardSimpleDeputyCounter> {
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  DashboardSimpleAbsentVoteDeputiesCounterMapper(this._subscribedDeputiesCache);

  @override
  Future<DashboardSimpleDeputyCounter> transform(DashboardAbsentVoteCounterDeputy response) async {
    final subscribedDeputy = await _subscribedDeputiesCache.getDeputyModelById(response.subscribedDeputyId);

    return DashboardSimpleDeputyCounter(subscribedDeputy, response.cardId, response.absentVote);
  }
}

class DashboardSimpleSpeechesCounterDeputiesCounterMapper extends AsyncDataMapper<DashboardSpeechesCounterDeputy, DashboardSimpleDeputyCounter> {
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  DashboardSimpleSpeechesCounterDeputiesCounterMapper(this._subscribedDeputiesCache);

  @override
  Future<DashboardSimpleDeputyCounter> transform(DashboardSpeechesCounterDeputy response) async {
    final subscribedDeputy = await _subscribedDeputiesCache.getDeputyModelById(response.subscribedDeputyId);

    return DashboardSimpleDeputyCounter(subscribedDeputy, response.cardId, response.speechesCounter);
  }
}

class DashboardSimpleDeputyCounterPerYearMapper extends AsyncDataMapper<DashboardDeputyCounter, DashboardSimpleDeputyCounterPerYear> {
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  DashboardSimpleDeputyCounterPerYearMapper(this._subscribedDeputiesCache);

  @override
  Future<DashboardSimpleDeputyCounterPerYear> transform(DashboardDeputyCounter response) async {
    final subscribedDeputy = await this._subscribedDeputiesCache.getDeputyModelById(response.subscribedDeputyId);

    return DashboardSimpleDeputyCounterPerYear(
      subscribedDeputy,
      response.perYear.map((perYear) => DashboardSimpleDeputyCounterYear(perYear.year, perYear.counter)).toList()
    );
  }
}