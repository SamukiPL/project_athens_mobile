import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_provider.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ads.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/data/speech_queue_setter.dart';
import 'package:project_athens/timeline_flow/data/timeline_repository_impl.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_meetings_dates.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_noun_cloud_use_case.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_timeline_use_case.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud_bloc.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_bloc.dart';
import 'package:provider/provider.dart';

class TimelineModule extends Module {

  TimelineModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final clubsCache = Provider.of<ParliamentClubsCache>(context);
    final subscribedDeputiesCache = Provider.of<SubscribedDeputiesCache>(context);
    final speechCache = Provider.of<SpeechCache>(context);
    final dio = Provider.of<Dio>(context);
    final localization = Provider.of<AppLocalizations>(context);
    TimelineApi timelineApi = TimelineApi(dio);
    TimelineRepository timelineRepository = TimelineRepositoryImpl(
        timelineApi,
        TimelineModelMapper(deputiesCache, clubsCache, subscribedDeputiesCache, localization),
        SpeechQueueSetter(speechCache));

    GetTimelineUseCase getTimelineUseCase = GetTimelineUseCase(timelineRepository);
    GetMeetingsDates getMeetingsDates = GetMeetingsDates(timelineRepository);
    GetNounCloudUseCase getNounCloudUseCase = GetNounCloudUseCase(timelineRepository);

    NounCloudBloc nounCloudBloc = NounCloudBloc(getNounCloudUseCase);

    return [
      Provider<TimelineBloc>(
        create: (context) => TimelineBloc(getTimelineUseCase, getMeetingsDates, nounCloudBloc),
        dispose: (context, bloc) => bloc.dispose(),
      ),
      Provider<NativeAdProvider>(
        create: (_) => NativeAdProvider(NativeAds.timelineAd),
        dispose: (_, provider) => provider.dispose(),
      )
    ];
  }

}