import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';

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
        item = VotingResponse.fromJson(json['item'] as Map<String, dynamic>);
        break;
      case TimelineEventType.SPEECH:
        item = SpeechResponse.fromJson(json['item'] as Map<String, dynamic>);
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