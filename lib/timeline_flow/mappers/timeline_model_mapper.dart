import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/timeline_flow/data/network/response/speech.dart';
import 'package:project_athens/timeline_flow/data/network/response/timeline_response.dart';
import 'package:project_athens/timeline_flow/data/network/response/voting.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';

class TimelineModelMapper extends DataMapper<Event, TimelineModel> {

  final DeputiesCache _deputiesCache;

  TimelineModelMapper(this._deputiesCache);

  @override
  TimelineModel transform(Event data) {
    switch (data.type) {
      case TimelineEventType.VOTING:
        return getVotingModel(data.item);
        break;
      case TimelineEventType.SPEECH:
        return getSpeechModel(data.item);
        break;
      default:
        throw Exception("There is no other type");
    }
  }

  TimelineModel getVotingModel(Voting item) {
    return VotingModel(item.id, item.topic, item.actualVotedAt);
  }

  TimelineModel getSpeechModel(Speech item) {
    return SpeechModel(
        item.id,
        item.personName,
        item.agenda?.title,
        item.cisInfo.eventDateTime,
        _deputiesCache.getDeputyThumbnail(item.cadencyDeputy)
    );
  }
}
