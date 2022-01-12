import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  final DashboardNearestMeetingResponse? meeting;
  final DashboardAbsentVoteCounterResponse? absentVote;
  final DashboardSpeechesCounterResponse? speechesCounter;
  final DashboardCounterPerYearResponse? absentVotePerYear;
  final DashboardCounterPerYearResponse? speechesCounterPerYear;

  DashboardResponse(
      this.meeting,
      this.absentVote,
      this.speechesCounter,
      this.absentVotePerYear,
      this.speechesCounterPerYear
  );

  factory DashboardResponse.fromJson(Map<String, dynamic> json) => _$DashboardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}

@JsonSerializable()
class DashboardNearestMeetingResponse {
  final DateTime nearestPastMeeting;
  final DateTime nearestMeeting;
  final String nearestPastMeetingId;
  final String nearestMeetingId;

  DashboardNearestMeetingResponse(
      this.nearestPastMeeting,
      this.nearestMeeting,
      this.nearestPastMeetingId,
      this.nearestMeetingId
  );

  factory DashboardNearestMeetingResponse.fromJson(Map<String, dynamic> json) => _$DashboardNearestMeetingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardNearestMeetingResponseToJson(this);
}

@JsonSerializable()
class DashboardAbsentVoteCounterResponse {
  final List<DashboardAbsentVoteCounterDeputy> perDeputy;
  final DateTime? updateAt;

  DashboardAbsentVoteCounterResponse(
    this.perDeputy,
    this.updateAt
  );

  factory DashboardAbsentVoteCounterResponse.fromJson(Map<String, dynamic> json) => _$DashboardAbsentVoteCounterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardAbsentVoteCounterResponseToJson(this);
}

@JsonSerializable()
class DashboardAbsentVoteCounterDeputy {
  final String subscribedDeputyId;
  final int cardId;
  final absentVote;

  DashboardAbsentVoteCounterDeputy(
    this.subscribedDeputyId,
    this.cardId,
    this.absentVote
  );

  factory DashboardAbsentVoteCounterDeputy.fromJson(Map<String, dynamic> json) => _$DashboardAbsentVoteCounterDeputyFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardAbsentVoteCounterDeputyToJson(this);
}

@JsonSerializable()
class DashboardSpeechesCounterResponse {
  final List<DashboardSpeechesCounterDeputy> perDeputy;
  final DateTime? updateAt;

  DashboardSpeechesCounterResponse(
      this.perDeputy,
      this.updateAt
      );

  factory DashboardSpeechesCounterResponse.fromJson(Map<String, dynamic> json) => _$DashboardSpeechesCounterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardSpeechesCounterResponseToJson(this);
}

@JsonSerializable()
class DashboardSpeechesCounterDeputy {
  final String subscribedDeputyId;
  final int cardId;
  final speechesCounter;

  DashboardSpeechesCounterDeputy(
      this.subscribedDeputyId,
      this.cardId,
      this.speechesCounter
      );

  factory DashboardSpeechesCounterDeputy.fromJson(Map<String, dynamic> json) => _$DashboardSpeechesCounterDeputyFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardSpeechesCounterDeputyToJson(this);
}

@JsonSerializable()
class DashboardCounterPerYearResponse {
  final List<DashboardDeputyCounter> perDeputy;
  final DateTime? updateAt;

  DashboardCounterPerYearResponse(
    this.perDeputy,
    this.updateAt
  );

  factory DashboardCounterPerYearResponse.fromJson(Map<String, dynamic> json) => _$DashboardCounterPerYearResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardCounterPerYearResponseToJson(this);
}

@JsonSerializable()
class DashboardDeputyCounter {
  final String subscribedDeputyId;
  final List<DashboardDeputyCounterPerYear> perYear;

  DashboardDeputyCounter(
    this.subscribedDeputyId,
    this.perYear
  );

  factory DashboardDeputyCounter.fromJson(Map<String, dynamic> json) => _$DashboardDeputyCounterFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardDeputyCounterToJson(this);
}

@JsonSerializable()
class DashboardDeputyCounterPerYear {
  final int year;
  final int counter;

  DashboardDeputyCounterPerYear(
      this.year,
      this.counter
  );

  factory DashboardDeputyCounterPerYear.fromJson(Map<String, dynamic> json) => _$DashboardDeputyCounterPerYearFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardDeputyCounterPerYearToJson(this);
}


