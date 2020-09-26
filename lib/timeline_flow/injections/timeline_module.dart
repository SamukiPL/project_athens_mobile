import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/cached_module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/data/timeline_repository_impl.dart';
import 'package:project_athens/timeline_flow/domain/get_meetings_dates.dart';
import 'package:project_athens/timeline_flow/domain/get_timeline_use_case.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';
import 'package:project_athens/timeline_flow/screens/timeline_bloc.dart';
import 'package:provider/provider.dart';

class TimelineModule extends CachedModule {

  final TimelineBloc _timelineBloc;

  final TimelineApi _timelineApi;

  TimelineModule._(this._timelineBloc, this._timelineApi, BuildContext context) : super(context);

  factory TimelineModule(BuildContext context) {
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final chopperClient = Provider.of<ChopperClient>(context);
    TimelineApi timelineApi = TimelineApi.create(chopperClient);
    TimelineRepository timelineRepository = TimelineRepositoryImpl(timelineApi, TimelineModelMapper(deputiesCache));
    GetTimelineUseCase getTimelineUseCase = GetTimelineUseCase(timelineRepository);
    GetMeetingsDates getMeetingsDates = GetMeetingsDates(timelineRepository);

    final timelineBloc = TimelineBloc(getTimelineUseCase, getMeetingsDates);
    return TimelineModule._(timelineBloc, timelineApi, context);
  }

  @override
  List<SingleChildWidget> getProviders() => [
    Provider<TimelineBloc>.value(
      value: _timelineBloc,
    )
  ];

  @override
  void disposeCache() {
    _timelineApi.dispose();
    _timelineBloc.dispose();
  }

}