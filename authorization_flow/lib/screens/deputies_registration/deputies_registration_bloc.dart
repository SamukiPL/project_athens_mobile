import 'package:athens_core/domain/result.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:athens_core/domain/base_repository.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_params.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_use_case.dart';
import 'package:authorization_flow/domain/deputies_registration/deputy_model.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model_factory.dart';
import 'package:pagination/paging_bloc.dart';
import 'package:pagination/paging_list_adapter.dart';

class DeputiesRegistrationBloc extends BaseBloc
    implements PagingBloc<DeputyItemViewModel> {
  final DeputiesRegistrationUseCase _deputiesRegistrationUseCase;

  @override
  PagingListAdapter<DeputyItemViewModel> adapter;

  @override
  int batchSize = 40;

  @override
  int page = 1;

  DeputiesRegistrationBloc(this._deputiesRegistrationUseCase) {
    adapter = PagingListAdapter(this);
    _loadFreshData();
  }

  Future<void> _loadFreshData() async {
    final result =
        await _deputiesRegistrationUseCase(DeputiesRegistrationParams(9)).safeApiCall();

    if (result is Success<List<DeputyModel>> ) {
      adapter.updateList(result.result.toDeputyItemViewModels());
    }
  }

  @override
  void loadMore() {}

  @override
  void dispose() {
    adapter.dispose();
  }
}
