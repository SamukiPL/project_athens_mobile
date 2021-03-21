import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputies_registration_params.dart';
import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputies_registration_use_case.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';

class DeputiesRegistrationBloc extends BaseBloc implements PagingBloc {
  final DeputiesRegistrationUseCase _deputiesRegistrationUseCase;

  @override
  PagingListAdapter adapter;

  @override
  int batchSize = 40;

  @override
  int offset = 1;

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
