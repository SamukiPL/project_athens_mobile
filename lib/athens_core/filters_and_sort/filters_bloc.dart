import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/base_filter_type.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';

class FiltersBloc extends BaseBloc {

  final FilterableFacade _facade;

  FiltersBloc(this._facade) {
    getFilters();
  }

  List<BaseFilterType> _filters = List();

  List<BaseFilterType> get filters => _filters;

  Future<void> getFilters() async {
    final result = await _facade.getFilters();
    if (result is Success<List<BaseFilterType>>) {
      _filters = result.value;
    }
    manageState(result);
  }

  Future<void> acceptFilters() async {
    _facade.changeFilters(filters.map((e) => e.copy()).toList());
  }

}