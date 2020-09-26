import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/athens_core/presentation/fab/fab_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model_factory.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';

class DeputiesChooserBloc extends BaseRegistrationStepBloc
    implements PagingBloc<DeputyItemViewModel> {
  final GetDeputiesUseCase _getDeputiesUseCase;
  final PutDeputiesUseCase _putDeputiesUseCase;

  @override
  PagingListAdapter<DeputyItemViewModel> adapter;

  @override
  int batchSize = 40;

  @override
  int page = 1;

  FabBloc _fabBloc = FabBloc(visible: false);

  FabBloc get fabBloc => _fabBloc;

  List<DeputyItemViewModel> _items;
  String _searchQuery = "";

  DeputiesChooserBloc(this._getDeputiesUseCase, this._putDeputiesUseCase) {
    adapter = PagingListAdapter(this);
    _loadFreshData();
  }

  Future<void> _loadFreshData() async {
    final result =
        await _getDeputiesUseCase(GetDeputiesParams(9));

    if (result is Success<List<DeputyModel>>) {
      _items = result.result.toDeputyItemViewModels(itemClick);
      adapter.updateList(_items);
    }
  }

  @override
  Future<void> loadMore() async {}

  @override
  void dispose() {
    super.dispose();
    adapter.dispose();
  }

  bool itemClick(DeputyItemViewModel item) {
    _fabBloc.setVisible(_items.any((item) => item.checked));
    return _items.where((item) => item.checked).length <= 20;
  }

  void setSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    if (_items != null) _updateListWithQuery();
  }

  Future<void> _updateListWithQuery() async {
    var startsWith = _items
        .where((item) => item.name.toLowerCase().startsWith(_searchQuery))
        .toList();
    var contains = _items
        .where((item) => item.name.toLowerCase().contains(_searchQuery))
        .toList();
    adapter.updateList((startsWith + contains).distinct());
  }

  Future<void> call() async {
    var result = await _putDeputiesUseCase(PutDeputiesParams(
        9,
        _items
            .where((item) => item.checked)
            .map((item) => PutDeputyModel(item.model.id, item.vote,
                item.speech, item.interpolation))
            .toList()));
    manageState(result);
  }

  @override
  Future<void> refresh() async {}
}
