import 'package:athens_core/domain/result.dart';
import 'package:athens_core/domain/base_repository.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:athens_core/presentation/fab/fab_bloc.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_params.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_use_case.dart';
import 'package:authorization_flow/domain/deputies_registration/deputy_model.dart';
import 'package:authorization_flow/domain/deputies_registration/put_deputy_model.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model_factory.dart';
import 'package:pagination/paging_bloc.dart';
import 'package:pagination/paging_list_adapter.dart';
import 'package:athens_core/ext/list_extension.dart';

class DeputiesRegistrationBloc extends BaseBloc
    implements PagingBloc<DeputyItemViewModel> {
  final DeputiesRegistrationUseCase _deputiesRegistrationUseCase;

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

  DeputiesRegistrationBloc(this._deputiesRegistrationUseCase) {
    adapter = PagingListAdapter(this);
    _loadFreshData();
  }

  Future<void> _loadFreshData() async {
    final result =
        await _deputiesRegistrationUseCase(DeputiesRegistrationParams(9))
            .safeApiCall();

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

  Future<void> onFabPressed() async {
    var result = await _deputiesRegistrationUseCase.putDeputies(
        DeputiesRegistrationParams(9),
        _items
            .where((item) => item.checked)
            .map((item) => PutDeputyModel(item.model.deputyId, item.vote,
                item.speech, item.interpolation))
            .toList());
    manageState(result);
  }

  @override
  Future<void> refresh() async {}
}
