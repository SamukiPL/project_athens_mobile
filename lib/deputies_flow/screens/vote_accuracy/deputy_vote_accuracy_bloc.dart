import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_list_impl/deputy_vote_accuracy_item_view_model_factory.dart';

class DeputyVoteAccuracyBloc extends BaseListBloc {
  final ListFacade _listUseCase;
  final DeputyVoteAccuracyItemViewModelFactory _itemFactory;

  DeputyVoteAccuracyBloc(this._itemFactory, this._listUseCase) : super(_listUseCase, _itemFactory);
}
