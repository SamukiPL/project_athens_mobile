import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/stepper_button_state_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model_factory.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/step_search_bar_bloc.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';

class DeputiesChooserBloc extends BaseRegistrationStepBloc
    implements PagingBloc {

  final DeputiesCache _deputiesCache;
  final PutDeputiesUseCase _putDeputiesUseCase;
  final StepSearchBarBloc _searchBarBloc;
  final StepperButtonStateBloc _stepperButtonStateBloc;

  @override
  late PagingListAdapter adapter;

  @override
  int batchSize = 40;

  @override
  int offset = 0;

  final int maxDeputyListen = 40;

  late List<DeputyItemViewModel> _items;
  String _searchQuery = "";

  DeputiesChooserBloc(this._deputiesCache, this._putDeputiesUseCase, this._searchBarBloc, this._stepperButtonStateBloc) {
    adapter = PagingListAdapter(this);
    _loadFreshData();
  }

  Future<void> _loadFreshData() async {
    final result = await _deputiesCache.deputies;

    if (result is Success<List<DeputyModel>>) {
      _items = result.value.toDeputyItemViewModels(itemClick);
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
    _stepperButtonStateBloc.changeState((_items.any((item) => item.checked))
        ? StepperButtonState.IDLE
        : StepperButtonState.DISABLE);

    final checkedCount = _items.where((item) => item.checked).length;

    updateHeaderHelperLine("Możesz zaznaczyć jeszcze " + (maxDeputyListen - checkedCount).toString() + ' posłów.');

    return _items.where((item) => item.checked).length <= maxDeputyListen;
  }

  void showSearchBar() {
    _searchBarBloc.show();
  }

  void setSearchQuery(String searchQuery) {
    _searchQuery = searchQuery.toLowerCase();
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
        _items
            .where((item) => item.checked)
            .map((item) => PutDeputyModel(
                item.model.id, item.vote, item.speech, item.interpolation))
            .toList()));
    manageState(result);
  }

  @override
  Future<void> refresh() async {
    _loadFreshData();
  }
}
