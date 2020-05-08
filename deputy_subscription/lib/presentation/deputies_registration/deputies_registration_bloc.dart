import 'package:athens_core/presentation/base_bloc.dart';
import 'package:deputy_subscription/domain/deputies_registration/deputies_registration_params.dart';
import 'package:deputy_subscription/domain/deputies_registration/deputies_registration_use_case.dart';
import 'package:deputy_subscription/presentation/deputies_registration/list/deputy_item_view_model.dart';
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
        await _deputiesRegistrationUseCase(DeputiesRegistrationParams(9));

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<void> refresh() async {
    // TODO: implement refresh
  }

  @override
  Future<void> loadMore() async {
    // TODO: implement loadMore
  }
}
