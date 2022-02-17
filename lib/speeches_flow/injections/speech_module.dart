import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/item_was_seen/seen_item_data_source.dart';
import 'package:project_athens/athens_core/domain/item_was_seen/speech_was_seen_use_case.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/main/wakelock/wakelock_service.dart';
import 'package:project_athens/speeches_flow/data/details_speech_network_data_source.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/speeches_flow/domain/get_speech_use_case.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_bloc.dart';
import 'package:provider/provider.dart';

class SpeechModule extends Module {
  final String speechId;
  final bool isNormalSpeech;

  SpeechModule(BuildContext context, this.speechId, this.isNormalSpeech) : super(context);

  late final SpeechDetailsBloc bloc;

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final speechesApi = SpeechesApi(dio);
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final clubsCache = Provider.of<ParliamentClubsCache>(context);
    final seenDataSource = Provider.of<SeenItemDataSource>(context);
    final networkMapper = SpeechesNetworkMapper(deputiesCache, clubsCache);
    final speechCache = Provider.of<SpeechCache>(context);

    final detailsSpeechNetworkDataSource = DetailsSpeechNetworkDataSource(speechesApi, networkMapper, speechId, isNormalSpeech, speechCache);
    final getSpeechUseCase = GetSpeechUseCase(detailsSpeechNetworkDataSource);

    final speechWasSeenUseCase = SpeechWasSeenUseCase(seenDataSource);

    final wakelock = Provider.of<WakelockService>(context);

    bloc = SpeechDetailsBloc(isNormalSpeech, getSpeechUseCase, deputiesCache, wakelock, speechWasSeenUseCase);

    return [
      Provider<SpeechDetailsBloc>.value(
        value: bloc,
      ),
    ];
  }

  @override
  void dispose() {
    bloc.dispose();
  }
}
