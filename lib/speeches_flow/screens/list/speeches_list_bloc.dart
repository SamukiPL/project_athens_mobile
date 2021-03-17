import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_facade.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_list_bloc.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';

class SpeechesListBloc
    extends BaseListBloc<SpeechModel, SpeechItemViewModel, BaseListParams> {
  SpeechesListBloc(ListFacade<SpeechModel, BaseListParams> listUseCase,
      DataMapper<SpeechModel, SpeechItemViewModel> itemFactory)
      : super(listUseCase, itemFactory);

  @override
  Function(SpeechModel p1) get itemClick => (SpeechModel model) {
        goToDestination(SpeechDetailsDestination(model));
  };
}
