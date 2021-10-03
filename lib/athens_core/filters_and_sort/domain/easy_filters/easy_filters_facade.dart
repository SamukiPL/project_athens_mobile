import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';

mixin EasyFiltersFacade<T> {
  abstract final EasyFiltersRepository<T> easyFiltersRepository;

  T? easyFilterValue;

  Future<Result<List<EasyFilterModel>>> getEasyFilters() =>
      easyFiltersRepository.getFilters();

  Future<void> changeFilterValue(T? filterValue) async {
    this.easyFilterValue = filterValue;
    refreshItems();
  }

  Future<void> refreshItems();


}
