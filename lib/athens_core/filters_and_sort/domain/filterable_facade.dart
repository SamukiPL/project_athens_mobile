import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/sorting_model.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/base_filter_type.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/date_from_to.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/sorting_filter.dart';

mixin FilterableFacade {

  FiltersRepository filtersRepository;

  List<BaseFilterType> filters;

  DateTime from = DateTimeExtension.defaultFrom();
  DateTime to = DateTimeExtension.defaultTo();
  
  String sortingParam = SortingModel.firstSortParam();

  Future<Result<List<BaseFilterType>>> getFilters({bool resetFilters = false}) async {
    if (resetFilters || filters == null)
      return filtersRepository.getFilters();
    else
      return Success(filters);
  }

  Future<void> changeFilters(List<BaseFilterType> filters) async {
    this.filters = filters;
    
    _setDates();
    _setSort();
    
    refreshItems();
  }
  
  void _setDates() {
    final dateTimeTo = filters.firstWhere((element) => element is DateFromTo) as DateFromTo;

    from = dateTimeTo.fromTime;
    to = dateTimeTo.toTime;
  }

  void _setSort() {
    final sortingFilter = filters.firstWhere((element) => element is SortingFilter) as SortingFilter;

    sortingParam = sortingFilter.currentSort.param;
  }

  Future<void> refreshItems();

}