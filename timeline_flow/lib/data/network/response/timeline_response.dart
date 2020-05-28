import 'package:json_annotation/json_annotation.dart';
import 'package:athens_core/models/gender.dart';
import 'package:timeline_flow/data/network/response/speech.dart';
import 'package:timeline_flow/data/network/response/voting.dart';

part 'timeline_response.g.dart';

@JsonSerializable(createToJson: false)
class TimelineResponse {

  final List<Event> events;

  TimelineResponse(this.events);

  factory TimelineResponse.fromJson(Map<String, dynamic> json) => _$TimelineResponseFromJson(json);
}

@JsonSerializable(createFactory: false, createToJson: false)
class Event {

  final TimelineItem item;
  final TimelineEventType type;

  Event(this.item, this.type);

  factory Event.fromJson(Map<String, dynamic> json) {
    TimelineEventType type = _TimelineEventTypeEnumMap[json["type"]];
    TimelineItem item;

    switch (type) {
      case TimelineEventType.VOTING:
        item = Voting.fromJson(json['item'] as Map<String, dynamic>);
        break;
      case TimelineEventType.SPEECH:
        item = Speech.fromJson(json['item'] as Map<String, dynamic>);
        break;
    }

    return Event(item, type);
  }
}

abstract class TimelineItem {}

enum TimelineEventType {
  VOTING,
  SPEECH
}

const _TimelineEventTypeEnumMap = {
  0: TimelineEventType.VOTING,
  1: TimelineEventType.SPEECH,
};