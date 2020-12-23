import 'dart:async';

import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_list_bloc.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';
import 'package:rxdart/rxdart.dart';

class SpeechesListBloc
    extends BaseListBloc<SpeechModel, SpeechItemViewModel, BaseParams> {
  SpeechesListBloc(
      ListUseCase<SpeechModel, BaseParams> listUseCase,
      BaseParams params,
      DataMapper<SpeechModel, SpeechItemViewModel> itemFactory)
      : super(listUseCase, params, itemFactory);

  @override
  Function(SpeechModel p1) get itemClick => (SpeechModel model) {
    goToDestination(SpeechDetailsDestination(model));
  };

}
