import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DashboardTilesDataModel {
  final DashboardNearestMeetingTileDataModel? nearestMeeting;
  final DashboardSimpleDeputiesCounter? absentVote;
  final DashboardSimpleDeputiesCounterPerYearDataModel? absentVotePerYear;
  final DashboardSimpleDeputiesCounter? speechesCounter;
  final DashboardSimpleDeputiesCounterPerYearDataModel? speechesCounterPerYear;

  DashboardTilesDataModel(
      {this.nearestMeeting,
      this.absentVote,
      this.absentVotePerYear,
      this.speechesCounter,
      this.speechesCounterPerYear});
}

class DashboardNearestMeetingTileDataModel {
  final DateTime nearestPastMeeting;
  final DateTime nearestMeeting;
  final String nearestPastMeetingId;
  final String nearestMeetingId;

  DashboardNearestMeetingTileDataModel(
    this.nearestMeeting,
    this.nearestPastMeeting,
    this.nearestPastMeetingId,
    this.nearestMeetingId
  );
}

class DashboardSimpleDeputiesCounter {
  final List<DashboardSimpleDeputyCounter> perDeputy;
  final DateTime? updateAt;

  DashboardSimpleDeputiesCounter(
    this.perDeputy,
    this.updateAt
  );
}

class DashboardSimpleDeputyCounter {
  final SubscribedDeputyModel subscribedDeputyModel;
  final int? cardId;
  final int counter;

  DashboardSimpleDeputyCounter(
    this.subscribedDeputyModel,
    this.cardId,
    this.counter
  );
}

class DashboardSimpleDeputiesCounterPerYearDataModel {
  final List<DashboardSimpleDeputyCounterPerYear> perDeputy;
  final DateTime? updateAt;

  DashboardSimpleDeputiesCounterPerYearDataModel(
    this.perDeputy,
    this.updateAt,
  );
}

class DashboardSimpleDeputyCounterPerYear {
  final SubscribedDeputyModel subscribedDeputyModel;
  final List<DashboardSimpleDeputyCounterYear> perYear;

  DashboardSimpleDeputyCounterPerYear(
    this.subscribedDeputyModel,
    this.perYear
  );
}

class DashboardSimpleDeputyCounterYear {
  final int year;
  final int counter;

  DashboardSimpleDeputyCounterYear(
      this.year,
      this.counter
  );
}