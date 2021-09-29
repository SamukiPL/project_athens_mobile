import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile_bloc.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/data/speech_queue_setter.dart';
import 'package:project_athens/timeline_flow/data/timeline_repository_impl.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_meetings_dates.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DashboardModule extends Module {
  DashboardModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;
    final _dio = Provider.of<Dio>(context);
    final _subscribedDeputiesCache = Provider.of<SubscribedDeputiesCache>(context);
    final _deputiesCache = Provider.of<DeputiesCache>(context);
    final _timelineModelMapper = TimelineModelMapper(_deputiesCache, _subscribedDeputiesCache, _localizations);
    final _speechCache = SpeechCache();
    final _speechQueueSetter = SpeechQueueSetter(_speechCache);

    final TimelineApi timelineApi = TimelineApi(_dio);
    final TimelineRepositoryImpl repository = TimelineRepositoryImpl(timelineApi, _timelineModelMapper, _speechQueueSetter);
    final GetMeetingsDates _getMeetingsDates = GetMeetingsDates(repository);
    
    return [
      Provider<DashboardBloc>(
        create: (context) => DashboardBloc(),
        dispose: (context, bloc) => bloc.dispose()
      ),
      Provider<NearestMeetingTileBloc>(
          create: (context) => NearestMeetingTileBloc(_getMeetingsDates, _localizations),
          dispose: (context, bloc) => bloc.dispose()
      )
    ];
  }
}