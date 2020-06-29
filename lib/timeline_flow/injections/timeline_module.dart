import 'package:project_athens/athens_core/injections/module.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/timeline_flow/domain/get_meetings_dates.dart';
import 'package:provider/provider.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/data/timeline_repository_impl.dart';
import 'package:project_athens/timeline_flow/domain/get_timeline_use_case.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';
import 'package:project_athens/timeline_flow/screens/timeline_bloc.dart';

class TimelineModule extends Module {
  TimelineModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final chopperClient = Provider.of<ChopperClient>(context);
    TimelineApi timelineApi = TimelineApi.create(chopperClient);
    TimelineRepository timelineRepository = TimelineRepositoryImpl(timelineApi, TimelineModelMapper(deputiesCache));
    GetTimelineUseCase getTimelineUseCase = GetTimelineUseCase(timelineRepository);
    GetMeetingsDates getMeetingsDates = GetMeetingsDates(timelineRepository);

    return [
      Provider<TimelineBloc>(
        create: (_) => TimelineBloc(getTimelineUseCase, getMeetingsDates),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}